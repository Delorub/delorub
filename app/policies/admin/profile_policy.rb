class Admin::ProfilePolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin_profile?
  end
end
