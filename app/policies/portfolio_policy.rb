class PortfolioPolicy < ApplicationPolicy
  def create?
    return false if user.blank?
    return false unless user.master?
    true
  end

  def update?
    granted?
  end

  def destroy?
    granted?
  end

  def restore?
    granted?
  end

  private

    def granted?
      return false if user.blank?
      return false unless user.master?
      user.id == record.user.id
    end
end
