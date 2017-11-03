class Entities::Task < Grape::Entity
  expose :id
  expose :title
  expose :price_exact
  expose :date_type
  expose :date_actual
  expose :date_interval_from
  expose :date_interval_to
  expose :description
  expose :date_created_at do |e|
    e.decorate.date_created_at
  end
  expose :human_date do |e|
    e.decorate.human_date(:date_without_year)
  end
  expose :place_address
end
