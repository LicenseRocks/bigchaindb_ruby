require 'spec_helper'

describe BigchainRuby::Transport do
  describe '#forward_request' do
    let(:node_urls) { ['http://node1.com', 'http://node2.com'] }
    subject { described_class.new(*node_urls) }

    before do
      stub_request(:get, "http://node1.com/foo")
        .with(body: "{\"bar\":1}")
        .to_return(body: {it: :worked}.to_json)

      stub_request(:get, "http://node2.com/foo")
        .with(body: "{\"bar\":2}")
        .to_return(body: {it: :worked_again}.to_json)
    end

    it 'does something' do
      expect(subject.forward_request(:get, '/foo', json: {bar: 1})).to eq({'it' => 'worked'})
      expect(subject.forward_request(:get, '/foo', json: {bar: 2})).to eq({'it' => 'worked_again'})
    end
  end
end
