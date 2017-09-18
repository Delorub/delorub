class Admin::PortfolioItemPolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin?
  end
end
