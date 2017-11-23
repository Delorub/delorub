class Entities::Portfolio < Grape::Entity
  expose :id
  expose :preview_url do |e|
    e.cover.url(:preview)
  end
  expose :small_url do |e|
    e.cover.url(:small)
  end
  expose :name
  expose :description
  expose :count_items do |e|
    e.portfolio_items.count
  end
  expose :portfolio_items, using: Entities::PortfolioItem
end
