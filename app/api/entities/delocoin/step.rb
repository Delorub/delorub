class Entities::Delocoin::Step < Grape::Entity
  expose :number
  expose :rate
  expose :date_from
  expose :is_current
  expose :is_past do |e|
    e.decorate.past?
  end
  expose :is_future do |e|
    e.decorate.future?
  end
end
