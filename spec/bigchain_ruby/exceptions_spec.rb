require 'spec_helper'

module BigchainRuby::Exceptions
  describe TransportError do
    subject { described_class.new(404, :not_found, {foo: :bar}) }

    it 'accepts status code, error and info' do
      expect(subject.status_code).to eq(404)
      expect(subject.error).to eq(:not_found)
      expect(subject.info).to eq(foo: :bar)
    end
  end
end
