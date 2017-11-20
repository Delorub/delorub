class Entities::PortfolioItem < Grape::Entity
  expose :id
  expose :preview_url do |item|
    item.file.url(:preview)
  end
  expose :small_url do |item|
    item.file.url(:small)
  end
  expose :thumb_url do |item|
    item.file.url(:thumb)
  end
  expose :description
end
