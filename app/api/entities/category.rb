class Entities::Category < Grape::Entity
  expose :id
  expose :title
  expose :parent_id
  expose :slug
  expose :photo_thumb_url do |e|
    e.photo.thumb.url
  end
end
