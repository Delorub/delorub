class Admin::PagePolicy < AdminPolicy
  def index?
    granted? || user.permission.admin_page_view?
  end
  
  def update?
    granted? || user.permission.admin_page_edit?
  end

  private

    def granted?
      super || user.permission.admin_page?
    end
end