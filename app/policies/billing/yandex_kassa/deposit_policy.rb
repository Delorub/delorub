class Billing::YandexKassa::DepositPolicy < ApplicationPolicy
  def confirm?
    is_owner?
    record.billing_log.new?
  end

  def is_owner?
    return false if user.blank?
    return false if record.billing_log.blank?
    record.billing_log.user_id == user.id
  end
end
