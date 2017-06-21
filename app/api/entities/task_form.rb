class Entities::TaskForm < Grape::Entity
  expose :id

  expose :title
  expose :description

  expose :main_category_id
  expose :category_id

  expose :files, with: Entities::TaskFile do |e|
    e.files.map(&:model)
  end

  expose :price_type
  expose :price_exact
  expose :price_type_options

  expose :date_type
  expose :date_actual_date do |e|
    I18n.l Time.zone.parse(e.date_actual_date), format: :datepicker_date
  end
  expose :date_actual_time
  expose :date_interval_from_date do |e|
    I18n.l Time.zone.parse(e.date_interval_from_date), format: :datepicker_date
  end
  expose :date_interval_to_date do |e|
    I18n.l Time.zone.parse(e.date_interval_to_date), format: :datepicker_date
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
