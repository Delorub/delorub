class Billing::Delocoin::BuyDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  include BillingHelper

  decorates Billing::Delocoin::Buy
  delegate_all

  def description
    "Стоимость пакета: #{format_balance_with_currency(cost)}"
  end
end
