class Api::V10::Portfolios < ApplicationAPI
  namespace :portfolios do
    namespace :temporary_covers do
      desc 'Upload a new temporary cover'
      params do
        requires :file, type: File, desc: 'File'
      end
      post do
        present Portfolio::TemporaryCover.create!(cover: params[:file]), with: Entities::Portfolio::TemporaryCover
      end
    end
  end
end
