module BillingHelper
  def format_balance number
    number_to_currency number, unit: '', precision: 0
  end
end
