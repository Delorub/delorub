class Admin::Delocoin::PackPolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin?
  end
end
