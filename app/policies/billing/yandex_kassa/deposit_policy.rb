class Billing::YandexKassa::DepositPolicy < ApplicationPolicy
  def confirm?
    billing_log_is_new?
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

  def billing_log_is_new?
    owner?
    record.billing_log.new?
  end

  private

    def owner?
      return false if user.blank?
      return false if record.billing_log.blank?
      record.billing_log.user_id == user.id
    end
end
