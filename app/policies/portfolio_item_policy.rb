class PortfolioItemPolicy < ApplicationPolicy
  def restore?
    destroy?
  end

  def destroy?
    return false if user.blank?
    return false unless user.master?
    record.portfolio.blank? || user.id == record.portfolio.user.id
  end
end
