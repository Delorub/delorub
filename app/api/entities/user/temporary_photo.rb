class Entities::User::TemporaryPhoto < Grape::Entity
  expose :id
  expose :photo_url do |e|
    e.photo.medium.url
  end
end
