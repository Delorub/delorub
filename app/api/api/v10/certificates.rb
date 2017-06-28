class Api::V10::Certificates < ApplicationAPI
  helpers ::Grape::AuthHelpers
  helpers ::Grape::PunditHelpers

  resource :certificates do
    desc 'Upload new certificate'
    params do
      requires :file, type: File
    end
    post do
      present Certificate.create!(file: params[:file]), with: Entities::Certificate
    end
  end
end
