class Entities::Portfolio < Grape::Entity
  expose :id
  expose :preview_url do |e|
    e.cover.url(:preview)
  end
  expose :name
  expose :description
  expose :count_items do |e|
    e.portfolio_items.count
  end
end
