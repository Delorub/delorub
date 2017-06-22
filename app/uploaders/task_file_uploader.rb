class TaskFileUploader < BaseUploader
  def filename
    "original.#{model.file.file.extension}" if original_filename
  end

  version :upload_preview do
    process resize_to_fill: [108, 108]
    process convert: 'jpg'

    def full_filename for_file = model.file.file
      'upload_preview.jpg'
    end
  end

  version :preview do
    process resize_to_fill: [130, 93]
    process convert: 'jpg'

    def full_filename for_file = model.file.file
      'preview.jpg'
    end
  end

  version :big_preview do
    process resize_to_fit: [380, 10000]
    process convert: 'jpg'

    def full_filename for_file = model.file.file
      'big_preview.jpg'
    end
  end
end
