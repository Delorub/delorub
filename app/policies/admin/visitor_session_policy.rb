class Admin::VisitorSessionPolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin?
  end
end
