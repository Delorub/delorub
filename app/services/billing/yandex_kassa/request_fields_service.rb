class Billing::YandexKassa::RequestFieldsService
  PAYMENT_TYPE = {
    'qiwi' => 'WQ',
    'yandex' => 'PC',
    'visa' => 'AC',
    'webmoney' => 'WM'
  }.freeze

  attr_reader :model

  def initialize model
    @model = model
  end

  def perform
    {
      shopId: Figaro.env.shop_id,
      scid: Figaro.env.scid,
      paymentType: PAYMENT_TYPE[model.pay_type],
      sum: model.amount.to_f,
      orderNumber: model.uuid,
      customerNumber: model.user.email
    }
  end
end
