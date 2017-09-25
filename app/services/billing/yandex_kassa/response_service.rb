class Billing::YandexKassa::ResponseService
  require 'builder'

  class_attribute :invoice_id, :shop_id, :response_code, :xml
  self.shop_id = Figaro.env.shop_id

  def initialize invoice_id, response_code
    @invoice_id = invoice_id
    @response_code = response_code.to_s
    @xml = Builder::XmlMarkup.new
    @xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'
  end

  def aviso_response
    xml.paymentAvisoResponse(xml_params)
    xml.target!
  end

  def check_response
    xml.checkOrderResponse(xml_params)
    xml.target!
  end

  private

    def xml_params
      { performedDatetime: Time.current.iso8601, code: response_code, invoiceId: invoice_id, shopId: shop_id }
    end
end
