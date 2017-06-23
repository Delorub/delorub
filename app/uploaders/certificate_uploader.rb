class CertificateUploader < BaseUploader
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb, if: :image? do
    process resize_to_limit: [245, 175]
    process convert: 'png'

    def full_filename for_file = model.photo.file
      'thumb.png'
    end
  end

  version :preview, if: :image? do
    process resize_to_limit: [100, 50]
    process convert: 'png'

    def full_filename for_file = model.photo.file
      'thumb.png'
    end
  end

  # def extension_whitelist
  #  %w(jpg jpeg gif png)
  # end
end
