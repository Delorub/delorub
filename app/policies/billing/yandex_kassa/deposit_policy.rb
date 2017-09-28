class Billing::YandexKassa::DepositPolicy < ApplicationPolicy
  def confirm?
    owner?
    record.billing_log.new?
  end

  def success?
    owner?
    return false if record.billing_log.failed?
    true
  end

  def fail?
    owner?
    return false if record.billing_log.finished?
    true
  end
end
