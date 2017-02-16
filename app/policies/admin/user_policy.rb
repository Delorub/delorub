class Admin::UserPolicy < AdminPolicy
  def index?
    granted? || user.permission.admin_user_view?
  end

  def update?
    granted? || user.permission.admin_user_edit?
  end

  def destroy?
    granted? || user.permission.admin_user_delete?
  end

  def permission?
    granted? || user.permission.admin_user_permissions?
  end

  def transfer_money?
    billing
  end

  def add_task_subscription?
    billing
  end

  def add_task_pack?
    billing
  end

  def add_reply_subscription?
    billing
  end

  def add_reply_pack?
    billing
  end

  def billing_log_sidebar?
    billing
  end

  def billing_sidebar?
    billing
  end

  private

    def billing
      granted? || user.permission.admin_user_billing?
    end

    def granted?
      super || user.permission.admin_user?
    end
end
