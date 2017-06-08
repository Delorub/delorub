class Entities::CreateProfileForm < Grape::Entity
  expose :main_specialization_id
  expose :specializations

  expose :about

  expose :notifications_type
  expose :notifications_type_options

  expose :paid_functions
  expose :paid_functions_options

  expose :place_id
end
