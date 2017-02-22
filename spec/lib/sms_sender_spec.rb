describe SmsSender do
  let(:phone) { '+79991234567' }
  let(:message) { 'test message' }
  let(:instance) { described_class.new phone: phone, message: message }

  describe '#perform' do
    let(:api_response) { { id: 1, cnt: 1 } }

    before do
      stub_request(:any, /#{Figaro.env.smsc_api_url}/).to_return(body: api_response.to_json)
    end

    subject { instance.perform }

    it { is_expected.to be true }
  end
end
