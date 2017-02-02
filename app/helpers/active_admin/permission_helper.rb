module ActiveAdmin::PermissionHelper
  def render_permissions form:, permission_resource:
    ActiveAdmin::PermissionRenderer.new(self, form, permission_resource).render
  end
  
  def permission_t k
    I18n.t!("activerecord.attributes.user_permission.#{k}") rescue k
  end
end
