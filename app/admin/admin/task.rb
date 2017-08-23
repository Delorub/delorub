ActiveAdmin.register Task, namespace: :admin do
  permit_params :user_id, :category_id, :title, :price_type, :date_type, :description, :visible, :price_exact, :price_from,
    :price_to, :place_lat, :place_long, :place_address, :date_actual, :date_interval_from, :date_interval_to,
    :notify_email, :archive, :price_scale, :contract_type

  filter :by_search_in, label: 'Поиск', as: :string
  filter :category_id, as: :ransack_filter, url: '/admin/categories', display_name: 'title'
  filter :user_id, as: :ransack_filter, url: '/admin/users', display_name: 'name'
  filter :created_at

  index do
    selectable_column
    column(:title) { |task| link_to task.title, admin_task_path(task) }
    column :user
    column :place_address
    column :created_at
    actions
  end

  form do |f|
    inputs do
      f.input :title
      f.input :category_id, as: :ransack_select, url: '/admin/categories', display_name: 'title'
      f.input :user_id,     as: :ransack_select, url: '/admin/users', display_name: 'name'
      f.input :description
      f.input :price_type
      f.input :date_type
      f.input :price_exact
      f.input :price_from
      f.input :price_to
      f.input :place_address
      f.input :date_actual,        as: :datepicker
      f.input :date_interval_from, as: :datepicker
      f.input :date_interval_to,   as: :datepicker
      f.input :notify_email
      f.input :price_scale
      f.input :contract_type
    end
    actions
  end

  show do
    h3 task.title
    attributes_table_for task do
      row :title
      row :user_id
      row :category_id
      row :price_type
      row :price_exact
      row :price_from
      row :price_to
      row :place_lat
      row :place_long
      row :place_address
      row :date_type
      row :date_actual
      row :date_interval_from
      row :date_interval_to
      row :description
      row :notify_email
      row :price_scale
      row :place
      row :place_lat
      row :place_long
      row :place_address
      row :contract_type
      row :created_at
    end
  end
end
