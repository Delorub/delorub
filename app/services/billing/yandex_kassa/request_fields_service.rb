class Billing::YandexKassa::RequestFieldsService
  include Rails.application.routes.url_helpers

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
      customerNumber: model.user.email,
      shopSuccessURL: "#{Figaro.env.base_url}#{success_my_yandex_endpoint_index_path}",
      shopFailURL: "#{Figaro.env.base_url}#{fail_my_yandex_endpoint_index_path}",
      ym_merchant_receipt: {
        'customerContact' => model.user.email,
        'taxSystem' => 1,
        'items' => [{
          'quantity' => 1,
          'price' => { 'amount' => model.amount.to_f },
          'tax' => 3,
          'text' => "Пополнение баланса на #{model.amount} руб."
        }]
      }
    }
  end
end
