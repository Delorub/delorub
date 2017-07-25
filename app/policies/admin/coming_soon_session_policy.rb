class Admin::ComingSoonSessionPolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin?
  end
end
