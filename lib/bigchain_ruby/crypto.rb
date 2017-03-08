require 'rbnacl'
class BigchainRuby::Crypto
  CryptoKeypair = Struct.new(:private_key, :public_key)

  def generate_keypair
    CryptoKeypair.new(private_key_to_base58, public_key_to_base58)
  end

  private

  def private_key_to_base58
    BigchainRuby::Base58.encode(signing_key.to_s)
  end

  def public_key_to_base58
    BigchainRuby::Base58.encode(signing_key.verify_key.to_s)
  end

  def signing_key
    @signing_key ||= ::RbNaCl::SigningKey.generate
  end
end
