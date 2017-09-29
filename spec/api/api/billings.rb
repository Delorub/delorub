require 'spec_helper'

describe Api::V10::Billings do
  include YandexKassaHelpers

  let(:user) { create :user }
  let(:state) { :new }
  let(:deposit) { create :billing_yandex_kassa_deposit, amount: 100, pay_type: 'qiwi', user: user, state: state }

  context 'Api by yandex kassa callback' do
    it 'POST check value success' do
      post '/api/billings/check', params: generate_yandex_hash(deposit, 'checkOrder')
      expect(response.status).to eq 200
      xml = parse_xml(response.body)['checkOrderResponse']
      expect(xml['code']).to eq '0'
    end

    it 'POST check value fail' do
      post '/api/billings/check', params: generate_yandex_hash(deposit, 'checkOrder', true)
      expect(response.status).to eq 200
      xml = parse_xml(response.body)['checkOrderResponse']
      expect(xml['code']).not_to eq '0'
    end

    it 'POST aviso value success' do
      post '/api/billings/process', params: generate_yandex_hash(deposit, 'paymentAviso')
      expect(response.status).to eq 200
      xml = parse_xml(response.body)['paymentAvisoResponse']
      expect(xml['code']).to eq '0'
    end

    it 'POST aviso value fail' do
      post '/api/billings/process', params: generate_yandex_hash(deposit, 'paymentAviso', true)
      expect(response.status).to eq 200
      xml = parse_xml(response.body)['paymentAvisoResponse']
      expect(xml['code']).not_to eq '0'
    end
  end

  private

    def parse_xml xml_content
      Hash.from_xml(xml_content)
    end
end
