class Admin::VisitorSessionActionPolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin?
  end
end
