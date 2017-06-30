class DealPolicy < ApplicationPolicy
  def show?
    return false if user.blank?
    user.id == record.task.user.id || user.id == record.profile.user.id
  end
end
