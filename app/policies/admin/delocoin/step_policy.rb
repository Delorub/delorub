class Admin::Delocoin::StepPolicy < AdminPolicy
  private

  def granted?
    super || user.permission.admin?
  end
end
