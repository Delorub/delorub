class Admin::HelpQuestionPolicy < AdminPolicy
  def reply?
    granted?
  end

  private

    def granted?
      super || user.permission.admin_help?
    end
end
