class Admin::CategoryPolicy < AdminPolicy
  def index?
    granted? || user.permission.admin_category_view?
  end

  def update?
    granted? || user.permission.admin_category_edit?
  end

  def destroy?
    granted? || user.permission.admin_category_delete?
  end

  private

    def granted?
      super || user.permission.admin_category?
    end
end
