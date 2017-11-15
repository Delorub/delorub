class Entities::Portfolio::TemporaryCover < Grape::Entity
  expose :id
  expose :cover_url do |e|
    e.cover.medium.url
  end
end
