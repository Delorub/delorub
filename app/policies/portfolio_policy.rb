class PortfolioPolicy < ApplicationPolicy
  def create?
    return false if user.blank?
    return false unless user.master?
    true
  end

  def update?
    return false if user.blank?
    return false unless user.master?
    user.id == record.profile.user_id
  end
end
