ActiveAdmin.register VisitorSession do
  index do
    selectable_column
    column :ip
    column :city
    actions
  end

  show do
    attributes_table do
      row :ip
      row :city
      row :created_at
    end

    table_for visitor_session.actions.order('id DESC') do
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
    end
  end
end
