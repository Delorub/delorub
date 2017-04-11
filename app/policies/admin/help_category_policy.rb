class Admin::HelpCategoryPolicy < AdminPolicy
  private

    def granted?
      super || user.permission.admin_help?
    end
end
