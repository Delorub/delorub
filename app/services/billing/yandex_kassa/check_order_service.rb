class Billing::YandexKassa::CheckOrderService < Billing::YandexKassaService
  self.action_name = 'checkOrder'

  def response
    xml = Builder::XmlMarkup.new
    xml.instruct! :xml, version: '1.0', encoding: 'UTF-8'

    xml.checkOrderResponse(performedDatetime: Time.current.iso8601,
                           code: code,
                           invoiceId: params[:invoice_id],
                           shopId: shop_id)
    xml.target!
  end

  private

  def code
    if valid_signature?
      valid_params? ? '0' : '100'
    else
      '1'
    end
  end

  def valid_params?
    if order
      order.amount.to_f == params[:order_sum_amount].to_f
    else
      false
    end
  end
end
