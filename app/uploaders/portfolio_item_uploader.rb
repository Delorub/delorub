class PortfolioItemUploader < BaseUploader
  include CarrierWave::MiniMagick

  version :small, if: :image? do
    process resize_to_fill: [66, 66]
    process convert: 'jpg'

    def full_filename for_file = model.photo.file
      'small.jpg'
    end
  end

  version :preview, if: :image? do
    process resize_to_fill: [118, 119]
    process convert: 'jpg'

    def full_filename for_file = model.photo.file
      'preview.jpg'
    end
  end

  version :thumb do
    process resize_to_limit: [750, 480]
    process convert: 'jpg'

    def full_filename for_file = model.file.file
      'thumb.jpg'
    end
  end
end
