class Api::V10::Users < Grape::API
  namespace :users do
    desc 'Upload temporary photo for user'
    params do
      requires :photo, type: File
    end
    post :temporary_photo do
      present User::TemporaryPhoto.create(photo: params[:photo]), with: Entities::UserTemporaryPhoto
    end
  end
end
