class Admin::CommentPolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin?
  end
end
