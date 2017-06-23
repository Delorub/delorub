class Entities::UserTemporaryPhoto < Grape::Entity
  expose :id
  expose :upload_preview_url do |e|
    e.photo.upload_preview.url
  end
end
