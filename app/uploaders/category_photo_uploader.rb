class CategoryPhotoUploader < BaseUploader
  def filename 
    "original.#{model.photo.file.extension}" if original_filename 
  end
  
  version :thumb do
    process resize_to_limit: [150, 150]
    process convert: 'png'
  
    def full_filename (for_file = model.photo.file)
      "thumb.png"
    end
  end
end
