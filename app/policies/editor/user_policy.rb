class Editor::UserPolicy < EditorPolicy
  def index?
    granted? || user.permission.editor_user_view?
  end

  def update?
    false
  end

  def destroy?
    false
  end
  
  def permission?
    granted? || user.permission.editor_user_permissions?
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
      granted? || user.permission.editor_user_billing?
    end

    def granted?
      super || user.permission.editor_user?
    end
end