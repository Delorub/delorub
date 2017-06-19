class Admin::CommentPolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin_profile?
  end
end
