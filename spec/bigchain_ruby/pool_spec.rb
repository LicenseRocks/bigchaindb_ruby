require 'spec_helper'

describe BigchainRuby::Pool do
  describe '#connection' do
    subject { described_class.new(connections) }

    context 'single connection' do
      let(:connection) { double }
      let(:connections) { [connection] }

      it 'returns the connection' do
        expect(subject.get_connection).to eq(connection)
      end
    end

    context 'several connections' do
      let(:connections) { [double, double, double] }
      let(:picker) { double }
      let(:picked_connection) { double }

      before do
        allow(BigchainRuby::RoundRobinPicker)
          .to receive(:new)
          .and_return(picker)
        allow(picker).to receive(:pick).and_return(picked_connection)
      end

      it 'returns the connection' do
        expect(subject.get_connection).to eq(picked_connection)
      end
    end
  end
end
