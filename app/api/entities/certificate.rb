class Entities::Certificate < Grape::Entity
  expose :id
  expose :profile_id
  expose :upload_preview_url do |e|
    e.file.upload_preview.url
  end
end
