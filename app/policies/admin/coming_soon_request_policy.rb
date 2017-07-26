class Admin::ComingSoonRequestPolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin?
  end
end
