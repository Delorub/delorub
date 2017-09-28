class Billing::YandexKassa::DepositDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  include BillingHelper

  decorates Billing::YandexKassa::Deposit
  delegate_all

  def description
    "Пополнение баланса на сумму: #{format_balance_with_currency(amount)}"
  end
end
