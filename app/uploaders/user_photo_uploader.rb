class UserPhotoUploader < BaseUploader
  def filename
    "original.#{model.photo.file.extension}" if original_filename
  end

  version :very_small do
    process resize_to_fill: [25, 25]
    process convert: 'png'

    def full_filename for_file = model.photo.file
      'very_small.png'
    end
  end

  version :small do
    process resize_to_fill: [50, 50]
    process convert: 'png'

    def full_filename for_file = model.photo.file
      'small.png'
    end
  end

  version :upload_preview do
    process resize_to_fill: [100, 100]
    process convert: 'png'

    def full_filename for_file = model.photo.file
      'upload_preview.png'
    end
  end
end
