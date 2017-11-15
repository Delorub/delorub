class Entities::PortfolioItem < Grape::Entity
  expose :id
  expose :preview_url do |item|
    item.file.url(:preview)
  end
  expose :description
end
