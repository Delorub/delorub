class Admin::ActiveAdmin::PagePolicy < AdminPolicy
  def show?
    granted? ||
      case record.name.downcase.to_sym
        when :dashboard then dashboard?
        when :search then search?
      end
  end

  def search?
    granted? || user.permission.admin_search?
  end

  def dashboard?
    granted? || user.permission.admin_dashboard?
  end
end
