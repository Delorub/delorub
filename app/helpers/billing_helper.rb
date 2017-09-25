module BillingHelper
  def format_balance number
    number_to_currency number, unit: '', precision: 0
  end

  def format_balance_with_currency number
    number_to_currency number, unit: 'руб', precision: 0
  end
end
