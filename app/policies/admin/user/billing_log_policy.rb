class Admin::User::BillingLogPolicy < AdminPolicy
  def create?
    false
  end
  
  def update?
    false
  end
  
  def destroy?
    false
  end

  private

    def granted?
      super || user.permission.admin_user_billing_log?
    end
end