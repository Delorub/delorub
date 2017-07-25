ActiveAdmin.register ComingSoonSession do
  permit_params :file, :profile_id

  index do
    selectable_column
    column :email
    column :city
    column :source
    column :source_data
    column :form_keyword
    actions
  end
end
