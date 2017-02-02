ActiveAdmin.register Task do
  permit_params :user_id, :category_id, :title, :price_type, :date_type
  
  filter :category_id, as: :ajax_filter, url: '/admin/categories', fields: [:title], display_name: 'title'
  filter :user_id, as: :ajax_filter, url: '/admin/users', fields: [:first_name, :last_name], display_name: 'name'
  filter :created_at
  
  index do
    selectable_column
    column(:title) { |task| link_to "#{task.title}", admin_task_path(task) }
    column :user
  end
end
