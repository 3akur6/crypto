require 'test/unit'

require_relative 'crypto'

class TestEncryptor < Test::Unit::TestCase

  include Crypto

  def test_encrypt
    assert_equal(Encryptor.encrypt("admin"), "WaQ7xbhc9TefbwK")
    assert_equal(Encryptor.encrypt("123456"), "0KcgeXhc9TefbwK")
  end

  def test_decrypt
    2.times do
      (1..15).each do |n|
        test_case = (32..127).to_a.shuffle.map(&:chr).take(n).join
        encrypt = Encryptor.encrypt(test_case)
        decrypt = Decryptor.decrypt(encrypt)
        assert(decrypt.any? { |x| x.include? test_case})
      end
    end
  end

end