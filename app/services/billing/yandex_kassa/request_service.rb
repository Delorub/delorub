class Billing::YandexKassa::RequestService
  PARAMS_MAP = {
    requestDatetime: :request_datetime,
    action: :action,
    md5: :md5,
    shopId: :shop_id,
    shopArticleId: :shop_article_id,
    invoiceId: :invoice_id,
    orderNumber: :order_id,
    customerNumber: :customer_number,
    orderCreatedDatetime: :order_created_datetime,
    orderSumAmount: :order_sum_amount,
    orderSumCurrencyPaycash: :order_sum_currency_paycash,
    orderSumBankPaycash: :order_sum_bank_paycash,
    shopSumAmount: :shop_sum_amount,
    shopSumCurrencyPaycash: :shopSumCurrencyPaycash,
    shopSumBankPaycash: :shop_sum_bank_paycash,
    paymentPayerCode: :payment_payer_code,
    paymentType: :payment_type
  }.freeze

  SIGNATURE_PARAMS = [:order_sum_amount,
                      :order_sum_currency_paycash, :order_sum_bank_paycash,
                      :shop_id, :invoice_id, :customer_number].freeze

  class_attribute :action_name, :shop_id, :password

  self.shop_id = Figaro.env.shop_id
  self.password = Figaro.env.shop_password

  attr_reader :params, :order

  def initialize controller_params, order, action_name
    @params = map_params(controller_params)
    @order = order
    @action_name = action_name
  end

  def valid_signature?
    values = [action_name] + SIGNATURE_PARAMS.map { |name| params[name].to_s } + [password]
    generate_signature(values) == params[:md5]
  end

  def valid_params?
    return false unless order
    return false unless valid_signature?
    order.amount.to_f == params[:order_sum_amount].to_f
  end

  private

    def map_params params
      hashable_array = PARAMS_MAP.map do |param, mapped_param|
        [mapped_param, params[param.to_s]]
      end
      HashWithIndifferentAccess[hashable_array]
    end

    def generate_signature *params
      Digest::MD5.hexdigest(params.join(';')).upcase
    end
end
