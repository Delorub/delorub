class Entities::TaskForm < Grape::Entity
  expose :id

  expose :title
  expose :description

  expose :main_category_id
  expose :category_id

  expose :files, with: Entities::TaskFile do |e|
    e.files.map { |file| file.model }
  end

  expose :price_type
  expose :price_exact
  expose :price_type_options

  expose :date_type
  expose :date_actual
  expose :date_actual_date
  expose :date_actual_time
  expose :date_type_options

  expose :place_id
  expose :place_address

  expose :contract_type
  expose :contract_type_options

  expose :notifications_type
  expose :notifications_type_options

  expose :paid_functions
  expose :paid_functions_options
end
