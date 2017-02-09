class UserPermissionData
  extend JsonSerializable
  include PermissionObject

  def self.pretty_permissions
    UserPermission::PERMISSIONS
  end
end