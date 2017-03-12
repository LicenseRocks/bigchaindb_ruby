require 'spec_helper'

describe BigchainRuby::Utils do
  describe '#normalize_nodes' do
    subject { described_class.new }

    context 'single node' do
      let(:examples) do
        [
          ['localhost', 'http://localhost:9984'],
          [nil, 'http://localhost:9984'],
          ['http://localhost', 'http://localhost:9984'],
          ['http://localhost:80', 'http://localhost:80'],
          ['https://node.xyz', 'https://node.xyz:443'],
          ['https://node.xyz/path', 'https://node.xyz:443/path']
        ]
      end

      it 'returns a normalized version of the node location' do
        examples.each do |(provided, expected)|
          expect(subject.normalize_nodes(provided)).to eq([expected])
        end
      end
    end

    context 'multiple nodes' do
      let(:examples) do
        [
          [['localhost', nil],['http://localhost:9984', 'http://localhost:9984']],
          [['https://node.xyz', 'localhost'], ['https://node.xyz:443', 'http://localhost:9984']],
        ]
      end
      it 'returns normalized versions of the node locations' do
        examples.each do |(provided, expected)|
          expect(subject.normalize_nodes(*provided)).to eq(expected)
        end
      end
    end
  end
end
