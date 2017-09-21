class Billing::YandexKassa::ResponceService
  class_attribute :invoice_id, :shop_id, :responce_code
  self.shop_id = Figaro.env.shop_id

  def initialize invoice_id, responce_code
    @invoice_id = invoice_id
    @responce_code = responce_code.to_s
  end
end
