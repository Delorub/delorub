class CreateProfileForm < Reform::Form
  include Composition

  property :main_category_id, on: :profile
  collection :categories,
    on: :profile,
    populator: ->(fragment:, **) {
      item = categories.find { |category| category.id == fragment['id'].to_i }
      item ? item : categories.append(Category.find_by(id: fragment['id']))
    } do
    property :id
  end

  property :temporary_photo_id, on: :user, virtual: true
  property :about, on: :profile
  property :place_id, on: :user

  property :price_type, default: 'hourly', on: :profile
  property :price_hourly, on: :profile
  property :price_project, on: :profile

  property :have_car, default: 'no', on: :profile
  property :have_instrument, default: 'no', on: :profile
  property :can_departure, default: 'no', on: :profile

  collection :working_days, on: :profile
  property :working_all_time, default: false, on: :profile
  property :working_hours_from, default: '10:00', on: :profile
  property :working_hours_to, default: '18:00', on: :profile

  property :notifications_type, virtual: true, default: 'notifications-email', on: :profile
  property :paid_functions, virtual: true, default: '', on: :profile

  def notifications_type_options
    [
      ['На email и в уведомлениях', 'notifications-email'],
      ['Только уведомления', 'notifications']
    ]
  end

  def paid_functions_options
    [
      ['Закрепить вверху', 'top']
    ]
  end

  def price_type_options
    Profile.price_type.options
  end

  def working_days_options
    Profile.working_days.options
  end
end
