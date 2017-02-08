class Admin::TaskPolicy < AdminPolicy
  private

    def granted?
      super || user.permission.admin_task?
    end
end