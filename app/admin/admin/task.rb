ActiveAdmin.register Task, namespace: :admin do
  permit_params :user_id, :category_id, :title, :price_type, :date_type

  filter :category_id, as: :ransack_filter, url: '/admin/categories', display_name: 'title'
  filter :user_id, as: :ransack_filter, url: '/admin/users', display_name: 'name'
  filter :created_at

  index do
    selectable_column
    column(:title) { |task| link_to task.title, admin_task_path(task) }
    column :user
  end

  form do |f|
    inputs do
      f.input :title
      f.input :category_id, as: :ransack_select, url: '/admin/categories', display_name: 'title'
      f.input :user_id, as: :ransack_select, url: '/admin/users', display_name: 'name'
      f.input :description
      f.input :visible
    end
    actions
  end
end
