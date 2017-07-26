ActiveAdmin.register ComingSoonRequest do
  permit_params :file, :profile_id

  index do
    selectable_column
    column :email
    column :visitor_session
    actions
  end
end
