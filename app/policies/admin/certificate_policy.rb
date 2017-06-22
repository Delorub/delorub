class Admin::CertificatePolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin_profile?
  end
end
