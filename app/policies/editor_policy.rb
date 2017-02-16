class EditorPolicy < ApplicationPolicy
  def index?
    granted?
  end

  def create?
    update?
  end

  def update?
    granted?
  end

  def destroy?
    granted?
  end

  private

    def granted?
      user.permission.superadmin? || user.permission.editor?
    end
end
