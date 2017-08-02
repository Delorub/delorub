ActiveAdmin.register VisitorSessionAction do
  permit_params :action_type, :session_id, :identity, :keyword, :url, :data

  navigation_menu :default
  menu false

  show do
    attributes_table do
      tag_row :action_type
      row :identity
      row :keyword
      row :url
      row :data
      row :created_at
    end
  end

  index do
    column :created_at do |visitor_session_action|
      link_to l(visitor_session_action.created_at, format: :long), admin_visitor_session_action_path(visitor_session_action)
    end
    tag_column :action_type
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
