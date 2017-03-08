require 'spec_helper'

describe BigchainRuby::Base58 do
  let(:decoded) do
    [
      228, 41, 187, 106, 36, 49, 23, 153, 83, 94, 144,
      119, 128, 108, 235, 63, 24, 31, 26, 133, 102, 222,
      136, 99, 10, 40, 218, 207, 235, 122, 144, 58
    ].pack('C*')
  end
  let(:encoded) { 'GMes4ftDtxHjKyrg6tTHUv7JFprb9ArRQVR9jMAo67zq' }

  describe '.encode' do
    it 'encodes the provided data using base 58' do
      expect(described_class.encode(decoded)).to eq(encoded)
    end
  end

  describe '.decode' do
    it 'decodes the provided string using base 58' do
      expect(described_class.decode(encoded)).to eq(decoded)
    end
  end
end
