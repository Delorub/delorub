class ProfilePolicy < ApplicationPolicy
  def create?
    return false if user.master?
    true
  end

  def edit?
    return false if user.blank?
    user.id == record.user_id
  end
end
