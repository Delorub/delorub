ActiveAdmin.register Profile, namespace: :admin do
  permit_params :work_type, :have_car, :about, :place_id, :price_type, :price_hourly, :price_project, :have_instrument,
    :can_departure, :working_all_time, :working_days, :working_hours_from, :working_hours_to, :rating_votes_count,
    :rating_votes_sum, :notifications_email_enabled, :birthday, :city_name, :user_id, category_ids: []

  filter :by_search_in, label: 'Поиск', as: :string
  filter :categories_id, label: 'Категория', as: :ransack_filter, url: '/admin/categories', display_name: 'title'

  form do |f|
    inputs 'Основное' do
      input :user, as: :select
      input :categories, as: :select
      input :about
      input :price_project
      input :rating_votes_count
      input :rating_votes_sum
      input :birthday
      input :city_name
    end
    actions
  end

  index do
    selectable_column
    column :name do |profile|
      link_to profile.user.decorate.name, admin_profile_path(profile)
    end
    actions
  end
end
