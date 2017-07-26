ActiveAdmin.register VisitorSessionAction do
  navigation_menu :default
  menu false

  index do
    column :created_at do |visitor_session_action|
      link_to l(visitor_session_action.created_at, format: :long), admin_visitor_session_action_path(visitor_session_action)
    end
    column :action_type
    column :identity
    column :keyword
    column :url do |visitor_session_action|
      if visitor_session_action.url
        link_to visitor_session_action.url.truncate(50), visitor_session_action.url
      end
    end
    actions
  end
end
