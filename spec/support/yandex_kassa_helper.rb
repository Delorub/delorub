module YandexKassaHelper
  YANDEX_PARAMS = {
    'requestDatetime' => Time.now.getlocal,
    'shopId' => Figaro.env.shop_id,
    'shopArticleId' => rand(10_000_000..99_999_999),
    'invoiceId' => rand(10_000_000_000..99_999_999_999),
    'orderCreatedDatetime' => Time.now.getlocal,
    'orderSumCurrencyPaycash' => rand(10_000..99_999),
    'orderSumBankPaycash' => rand(1000..9999),
    'shopSumCurrencyPaycash' => rand(10_000..99_999),
    'shopSumBankPaycash' => rand(1000..9999),
    'paymentPayerCode' => rand(10_000_000..99_999_999)
  }.freeze

  SIGNATURE_PARAMS = %w[orderSumCurrencyPaycash orderSumBankPaycash shopId invoiceId].freeze

  def generate_yandex_hash model, action_name, fail_hash = false
    {
      'md5' => fail_hash ? SecureRandom.uuid : generate_md5(model, action_name),
      'orderNumber' => model.uuid,
      'customerNumber' => model.user.email,
      'orderSumAmount' => model.amount.to_f,
      'shopSumAmount' => model.amount.to_f,
      'paymentType' => model.pay_type
    }.merge(YANDEX_PARAMS)
  end

  def generate_md5 model, action_name
    signature_param = SIGNATURE_PARAMS.map { |a| YANDEX_PARAMS[a].to_s }
    values = [action_name, model.amount.to_s] + signature_param + [model.user.email, Figaro.env.shop_password]
    Digest::MD5.hexdigest(values.join(';')).upcase
  end
end
