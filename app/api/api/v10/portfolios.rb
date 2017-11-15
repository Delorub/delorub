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

    desc 'Delete portfolio'
    delete ':id' do
      authenticate!
      portfolio = Portfolio.find(params[:id])
      authorize portfolio, :destroy?

      present portfolio.destroy, with: Entities::Portfolio
    end

    namespace :restore do
      desc 'Restore portfolio'
      delete ':id' do
        authenticate!
        portfolio = Portfolio.only_deleted.find(params[:id])
        authorize portfolio, :restore?

        present portfolio.restore, with: Entities::Portfolio
      end
    end
  end
end
