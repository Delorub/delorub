class PortfolioItemUploader < BaseUploader
  version :thumb, if: :image? do
    process resize_to_limit: [245, 175]
    process convert: 'jpg'

    def full_filename for_file = model.photo.file
      'thumb.jpg'
    end
  end

  version :preview, if: :image? do
    process resize_to_limit: [100, 50]
    process convert: 'jpg'

    def full_filename for_file = model.photo.file
      'preview.jpg'
    end
  end

  version :upload_preview do
    process resize_to_fill: [108, 108]
    process convert: 'jpg'

    def full_filename for_file = model.file.file
      'upload_preview.jpg'
    end
  end

  # def extension_whitelist
  #  %w(jpg jpeg gif png)
  # end
end
