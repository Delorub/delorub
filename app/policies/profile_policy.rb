class ProfilePolicy < ApplicationPolicy
  def create?
    return false if user.profile.present?
    true
  end
end
