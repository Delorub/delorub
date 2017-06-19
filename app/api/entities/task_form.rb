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
  expose :date_actual_date do |e|
    e.model.decorate.formatted_date_actual_date
  end
  expose :date_actual_time do |e|
    e.model.decorate.formatted_date_actual_time
  end
  expose :date_interval_from do |e|
    e.model.decorate.formatted_date_interval_from
  end
  expose :date_interval_to do |e|
    e.model.decorate.formatted_date_interval_to
  end
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
