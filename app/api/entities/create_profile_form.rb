class Entities::CreateProfileForm < Grape::Entity
  expose :main_specialization_id
  expose :categories

  expose :about

  expose :have_car do |e|
    e.have_car ? 'yes' : 'no'
  end
  expose :have_instrument do |e|
    e.have_instrument ? 'yes' : 'no'
  end
  expose :can_departure do |e|
    e.can_departure ? 'yes' : 'no'
  end
  expose :working_all_time
  expose :working_hours_from
  expose :working_hours_to
  expose :working_days
  expose :working_days_options

  expose :notifications_type
  expose :notifications_type_options

  expose :paid_functions
  expose :paid_functions_options

  expose :price_type
  expose :price_type_options

  expose :place_id
end
