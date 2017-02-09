class ActiveAdmin::UserPermission::AdminDecorator < Draper::Decorator
  decorates :user_permission
  delegate_all

  def pretty_permissions_list
    data.class.pretty_permissions
  end

  def permissions_list
    data.class.permissions
  end
end