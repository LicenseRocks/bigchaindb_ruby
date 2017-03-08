require 'spec_helper'

describe BigchainRuby::Crypto do
  describe '#generate_keypair' do
    subject { described_class.new.generate_keypair }

    it 'returns a new crypto keypair instance' do
      expect(subject).to be_a(BigchainRuby::Crypto::CryptoKeypair)
      expect(subject.private_key.length).to eq(44)
      expect(subject.public_key.length).to eq(44)
    end
  end
end
