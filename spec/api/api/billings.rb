require 'spec_helper'

describe Api::V10::Billings do
  let(:user) { create :user }
  let(:deposit) { create :deposit }
  let(:params) { FactoryGirl.attributes_for(:deposit) }

  YANDEX_PARAMS = {
    requestDatetime: Time.now.getlocal,
    shopId: Figaro.env.shop_id,
    shopArticleId: rand(10_000_000..99_999_999),
    invoiceId: rand(10_000_000_000..99_999_999_999),
    orderCreatedDatetime: Time.now.getlocal,
    orderSumCurrencyPaycash: rand(10_000..99_999),
    orderSumBankPaycash: rand(1000..9999),
    shopSumCurrencyPaycash: rand(10_000..99_999),
    shopSumBankPaycash: rand(1000..9999),
    paymentPayerCode: rand(10_000_000..99_999_999)
  }.freeze

  SIGNATURE_PARAMS = [:orderSumCurrencyPaycash, :orderSumBankPaycash,
                      :shopId, :invoiceId].freeze

  context 'Api by yandex kassa callback' do
    it 'POST check value success' do
      post '/api/billings/check', params: generate_yandex_hash('checkOrder')
      expect(response.status).to eq 201
      xml = parse_xml(response.body)['checkOrderResponse']
      expect(xml['code']).to eq '0'
    end

    it 'POST aviso value fail' do
      post '/api/billings/check', params: generate_yandex_hash('checkOrder', true)
      expect(response.status).to eq 201
      xml = parse_xml(response.body)['checkOrderResponse']
      expect(xml['code']).not_to eq '0'
    end

    it 'POST aviso value success' do
      post '/api/billings/process', params: generate_yandex_hash('paymentAviso')
      expect(response.status).to eq 201
      xml = parse_xml(response.body)['paymentAvisoResponse']
      expect(xml['code']).to eq '0'
    end

    it 'POST aviso value fail' do
      post '/api/billings/process', params: generate_yandex_hash('paymentAviso', true)
      expect(response.status).to eq 201
      xml = parse_xml(response.body)['paymentAvisoResponse']
      expect(xml['code']).not_to eq '0'
    end
  end

  private

    def generate_yandex_hash action_name, fail_hash = false
      {
        md5: fail_hash ? SecureRandom.uuid : generate_md5(action_name),
        orderNumber: deposit.uuid,
        customerNumber: user.email,
        orderSumAmount: deposit.amount.to_f,
        shopSumAmount: deposit.amount.to_f,
        paymentType: deposit.pay_type
      }.merge(YANDEX_PARAMS)
    end

    def generate_md5 action_name
      signature_param = SIGNATURE_PARAMS.map { |a| YANDEX_PARAMS[a].to_s }
      values = [action_name, deposit.amount.to_s] + signature_param + [user.email, Figaro.env.shop_password]
      Digest::MD5.hexdigest(values.join(';')).upcase
    end

    def parse_xml xml_content
      Hash.from_xml(xml_content)
    end
end
