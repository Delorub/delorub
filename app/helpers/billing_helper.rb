module BillingHelper
  def format_balance number
    number_to_currency number, unit: '', precision: 0
  end

  def history_state_class state
    case state
      when 'new' then 'table-history__processing'
      when 'finished' then 'table-history__successful'
      when 'failed' then 'table-history__error'
    end
  end
end