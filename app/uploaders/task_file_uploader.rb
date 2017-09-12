class TaskFileUploader < BaseUploader
  version :preview, if: :image? do
    process resize_to_fill: [200, 200]
    process convert: 'jpg'

    def full_filename for_file = model.file.file
      'preview.jpg'
    end
  end

  version :upload_preview, if: :image? do
    process resize_to_fill: [120, 120]
    process convert: 'jpg'

    def full_filename for_file = model.file.file
      'upload_preview.jpg'
    end
  end
end
