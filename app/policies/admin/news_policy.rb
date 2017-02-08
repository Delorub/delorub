class Admin::NewsPolicy < AdminPolicy
  def index?
    granted? || user.permission.admin_news_view?
  end
  
  def update?
    granted? || user.permission.admin_news_edit?
  end

  def destroy?
    granted? || user.permission.admin_news_delete?
  end

  private

    def granted?
      super || user.permission.admin_news?
    end
end