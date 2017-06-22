class Api::V10::Uploads < Grape::API
  namespace :uploads do
    desc 'Upload files to the task', entity: Entities::TaskFile
    params do
      requires :file, type: File
    end
    post :task do
      present TaskFile.create(file: params[:file]), with: Entities::TaskFile
    end
  end
end
