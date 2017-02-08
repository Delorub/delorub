class Admin::ActiveAdmin::PagePolicy < AdminPolicy
  def show?
    granted? || case record.name.downcase.to_sym
      when :dashboard then user.permission.admin_dashboard?
      when :search then user.permission.admin_search?
    end
  end
end