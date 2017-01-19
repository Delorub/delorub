ActiveAdmin.register Task do
  permit_params :user_id, :category_id, :title, :price_type, :geo_type, :date_type
  
  filter :category
  filter :user
  filter :created_at
  
  index do
    selectable_column
    column(:title) { |task| link_to "#{task.title}", admin_task_path(task) }
    column :user
  end
end
