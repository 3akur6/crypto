module Crypto

  SEED = "RDpbLfCPsJZ7fiv"
  FACTOR = "yLwVl0zKqws7LgKPRQ84Mdt708T1qQ3Ha7xv3H7NyU84p21BriUWBU43odz3iP4rBL3cD02KZciXTysVXiV8ngg6vL48rPJyAUw0HurW20xqxv9aYb4M9wK1Ae0wlro510qXeU07kV57fQMc8L6aLgMLwygtc0F10a0Dg70TOoouyFhdysuRMO51yY5ZlOZZLEal1h0t9YQW0Ko7oBwmCAHoic4HYbUyVeU3sfQ1xtXcPcf1aT303wAQhv66qzW"

  class Encryptor

    attr_accessor :plain

    def self.encrypt(plain)
      self.new(plain).encrypt
    end

    def initialize(plain)
      @plain = plain
    end

    def encrypt
      return @cipher if instance_variable_defined? :@cipher
      @cipher = (0...([@plain.length, 15].max)).inject("") do |memo, x|
        a = SEED[x].ord rescue 187
        b = @plain[x].ord rescue 187
        memo += FACTOR[(a ^ b) % 255]
      end
    end

    alias_method :cipher, :encrypt

  end

  class Decryptor

    attr_accessor :cipher

    def self.decrypt(cipher)
      self.new(cipher).decrypt
    end

    def initialize(cipher)
      @cipher = cipher
    end

    def find
      return @cache if instance_variable_defined? :@cache
      @cache = {}
      FACTOR.each_char.with_index { |x, idx| (@cache[x] ||= []) << idx }
      @cache
    end

    def decrypt
      return @plain if instance_variable_defined? :@plain
      @possible = []
      @cipher.chars.map(&:ord).each_with_index do |c, idx|
        find[c.chr].each do |x|
          if (32..127).include? (SEED[idx].ord rescue 187) ^ x
            (@possible[idx] ||= []) << ((SEED[idx].ord rescue 187) ^ x).chr
          else
            next
          end
        end
        break if @possible[idx].nil?
      end
      @plain = @possible[0].product(*@possible.drop(1)).map(&:join)
    end

    alias_method :plain, :decrypt

  end

end