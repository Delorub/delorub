class UserPolicy < ApplicationPolicy
  def update?
    return false if user.blank?
    record.user.id == user.id
  end
end
