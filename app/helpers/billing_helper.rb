module BillingHelper
  def format_balance number
    number_to_currency number, unit: '', precision: 0
  end

  def formatted_pay_type pay_type
    I18n.t("billing.pay_type.#{pay_type}")
  end

  def history_state_class state
    case state
      when 'new' then 'table-history__processing'
      when 'finished' then 'table-history__successful'
      when 'failed' then 'table-history__error'
    end
  end

  def format_balance_with_currency number
    number_to_currency number, unit: 'руб', precision: 0
  end
end
