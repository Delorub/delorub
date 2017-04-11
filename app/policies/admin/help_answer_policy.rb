class Admin::HelpAnswerPolicy < AdminPolicy
  private

    def granted?
      super || user.permission.admin_help?
    end
end
