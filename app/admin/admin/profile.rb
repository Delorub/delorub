ActiveAdmin.register Profile, namespace: :admin do
  permit_params :work_type, :have_car, :about, :place_id, :price_type, :price_hourly, :price_project, :have_instrument,
    :can_departure, :working_all_time, :working_days, :working_hours_from, :working_hours_to, :rating_votes_count,
    :rating_votes_sum, :notifications_email_enabled, category_ids: []

  filter :by_search_in, label: 'Поиск', as: :string
  filter :categories_id, label: 'Категория', as: :ransack_filter, url: '/admin/categories', display_name: 'title'

  form do |f|
    inputs 'Основное' do
      input :categories, as: :select
      input :work_type
      input :have_car
      input :about
      input :price_type
      input :price_hourly
      input :price_project
      input :have_instrument
      input :can_departure
      input :working_all_time
      input :working_days
      input :working_hours_from
      input :working_hours_to
      input :rating_votes_count
      input :rating_votes_sum
      input :notifications_email_enabled
    end
    actions
  end

  index do
    selectable_column
    column :name do |profile|
      link_to profile.name, admin_profile_path(profile)
    end
    actions
  end
end
