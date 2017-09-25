class Billing::YandexKassa::DepositDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  include BillingHelper

  decorates Billing::YandexKassa::Deposit
  delegate_all

  def formatted_pay_type
    I18n.t("yandex_kassa.pay_type.#{pay_type}")
  end

  def description
    "Пополнение баланса на сумму: #{format_balance_with_currency(amount)}"
  end
end
