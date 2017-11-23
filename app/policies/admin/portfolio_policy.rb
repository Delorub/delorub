class Admin::PortfolioPolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin?
  end
end
