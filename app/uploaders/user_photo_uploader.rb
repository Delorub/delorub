class UserPhotoUploader < BaseUploader
  def default_url
    '/images/avatars/missing.png'
  end

  version :small do
    process resize_to_fill: [108, 108]
    process convert: 'png'

    def full_filename for_file = model.photo.file
      'small.png'
    end
  end

  version :medium do
    process resize_to_fill: [193, 193]
    process convert: 'png'

    def full_filename for_file = model.photo.file
      'medium.png'
    end
  end
end
