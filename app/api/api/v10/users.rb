class Api::V10::Users < ApplicationAPI
  namespace :users do
    namespace :temporary_photos do
      desc 'Upload a new temporary photo'
      params do
        requires :file, type: File, desc: 'File'
      end
      post do
        present User::TemporaryPhoto.create!(photo: params[:file]), with: Entities::User::TemporaryPhoto
      end
    end
  end
end
