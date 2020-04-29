require 'test/unit'

require_relative 'crypto'

class TestEncryptor < Test::Unit::TestCase

  include Crypto

  def test_encrypt
    assert_equal(Encryptor.encrypt("admin"), "WaQ7xbhc9TefbwK")
    assert_equal(Encryptor.encrypt("123456"), "0KcgeXhc9TefbwK")
  end

  def test_decrypt
    assert_equal(Decryptor.decrypt("WaQ7xbhc9TefbwK"), [["a", "5"], ["d", "+"], ["a", "m"], ["i", "u", "C", "D"], ["n", "&", " "]])
    assert_equal(Decryptor.decrypt("0KcgeXhc9TefbwK"), [["W", "J", "1", ";", "("], ["C", "J", "2"], ["3", "9"], ["o", "7", "4"], ["5"], ["-", "6"]])
  end

  def test_decrypt!
    1.times do
      (1..15).each do |n|
        test_case = (32..127).to_a.shuffle.map(&:chr).take(n).join
        encrypt = Encryptor.encrypt(test_case)
        decrypt = Decryptor.decrypt!(encrypt)
        # puts "c_len: #{n}, char_len: #{Decryptor.decrypt(encrypt).flatten.length}"
        # puts "c_len: #{n}, p_len: #{Decryptor.decrypt(encrypt).length}"
        assert(decrypt.any? { |x| x.include? test_case })
      end
    end
  end

end