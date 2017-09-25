class User::BillingLogPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def finish?
    record.may_finish? && owner?
  end

  def fail?
    owner?
  end
end
