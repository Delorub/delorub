class ProfilePolicy < ApplicationPolicy
  def create?
    return false if user.present? && user.master?
    true
  end

  def edit?
    return false if user.blank?
    user.id == record.user_id
  end

  def personal_task?
    return true if user.blank?
    user.id != record.user_id
  end
end
