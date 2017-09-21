class Billing::YandexKassa::Responce::CheckService < Billing::YandexKassa::ResponceService
  def response
    xml = Builder::XmlMarkup.new
    xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
    xml.checkOrderResponse(performedDatetime: Time.current.iso8601,
                           code: responce_code,
                           invoiceId: invoice_id,
                           shopId: shop_id)
    xml.target!
  end
end
