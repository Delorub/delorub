class ActiveAdmin::UserPermission::EditorDecorator < Draper::Decorator
  decorates :user_permission
  delegate_all

  def pretty_permissions_list
    data.class.pretty_permissions.select { |k, v| k == :editor }
  end

  def permissions_list
    data.class.permissions.select { |k| k.to_s.start_with? 'editor' }
  end
end
