require 'spec_helper'

describe BigchainRuby::Connection do
  describe '#request' do
    subject { described_class.new(node_url: 'http://dummy.com') }

    context 'content type handling' do
      context 'content type json' do
        let(:response) do
          subject.request(:get, '/foo', json: {my: 'params'}, headers: {custom: :header} )
        end

        before do
          stub_request(:get, "http://dummy.com/foo")
            .with(
              body: "{\"my\":\"params\"}",
              headers: {
                'Content-Type'=>'application/json; charset=UTF-8',
                'Custom'=>'header',
              }
            )
            .to_return(:status => 200, :body => {my: 'response'}.to_json)
        end

        it 'returns the data and status code' do
          expect(response.status_code).to eq(200)
          expect(response.data).to eq({'my' => 'response'})
        end
      end
    end
  end
end
