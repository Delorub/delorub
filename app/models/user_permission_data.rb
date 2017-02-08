class UserPermissionData
  extend JsonSerializable
  include PermissionObject

  def self.pretty_permissions
    {
      admin:
      {
        dashboard: [],
        search: [],
        place: [],
        user_billing_log: [],
        task: [ :view, :edit, :delete ],
        category: [ :view, :edit, :delete ],
        news: [ :view, :edit, :delete ],
        user: [ :view, :edit, :delete, :permissions, :billing ],
        page: [ :view, :edit ],
        reply: []
      },

      editor:
      {
        dashboard: [],
        user: [ :permissions, :block, :billing ],
        news: [],
        task: [],
        reply: []
      },
      
      superadmin: []
    }
  end
end