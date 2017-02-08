class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file
  
  def cache_dir
    Rails.root.join 'tmp/uploads'
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
