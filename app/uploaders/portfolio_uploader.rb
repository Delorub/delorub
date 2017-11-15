class PortfolioUploader < BaseUploader
  include CarrierWave::MiniMagick

  version :medium, if: :image? do
    process resize_to_fill: [183, 176]
    process convert: 'jpg'

    def full_filename for_file = model.cover.file
      'medium.jpg'
    end
  end

  version :preview, if: :image? do
    process resize_to_fill: [240, 170]
    process convert: 'jpg'

    def full_filename for_file = model.cover.file
      'preview.jpg'
    end
  end
end
