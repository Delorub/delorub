class Admin::Billing::ManualTransferPolicy < AdminPolicy
  def confirm_manual_transfer?
    granted?
  end

  private

  def granted?
    super || user.permission.admin_page?
  end
end
