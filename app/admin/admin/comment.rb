ActiveAdmin.register Comment do
  permit_params :text, :parent_id

  form do |f|
    inputs 'Основное' do
      input :text
      input :parent
    end
    actions
  end

  index do
    selectable_column
    column :text
    column :parent
    column :user do |comment|
      link_to comment.user.decorate.name, admin_user_path(comment.user)
    end
    actions
  end
end
