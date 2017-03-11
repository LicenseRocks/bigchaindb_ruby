require 'spec_helper'

describe BigchainRuby::RoundRobinPicker do
  describe '#pick' do
    let(:first_connection) { double }
    let(:second_connection) { double }
    let(:connections) { [first_connection, second_connection] }
    subject { described_class.new(connections) }

    it 'does something' do
      expect(subject.pick(connections)).to eq(first_connection)
      expect(subject.pick(connections)).to eq(second_connection)
      expect(subject.pick(connections)).to eq(first_connection)
      expect(subject.pick(connections)).to eq(second_connection)
    end
  end
end
