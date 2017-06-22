class CreateProfileForm < Reform::Form
  property :main_specialization_id, virtual: true

  collection :categories do
    property :category_id
  end

  property :about
  property :place_id

  property :price_type, default: 'hourly'
  property :price_hourly
  property :price_project

  property :have_car, default: false
  property :have_instrument, default: false
  property :can_departure, default: false

  property :working_days
  property :working_all_time, default: false
  property :working_hours_from, default: '10:00'
  property :working_hours_to, default: '18:00'

  property :notifications_type, virtual: true, default: 'notifications-email'
  property :paid_functions, virtual: true, default: []

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
