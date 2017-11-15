class Api::V10::PortfolioItems < ApplicationAPI
  namespace :portfolio_items do
    namespace :files do
      desc 'Upload a new file'
      params do
        requires :file, type: File, desc: 'File'
      end
      post do
        present PortfolioItem.create!(file: params[:file]), with: Entities::PortfolioItem
      end
    end

    desc 'Delete portfolio item'
    delete ':id' do
      authenticate!
      item = PortfolioItem.find(params[:id])
      authorize item, :destroy?

      present item.destroy, with: Entities::PortfolioItem
    end

    namespace :restore do
      desc 'Restore portfolio item'
      delete ':id' do
        authenticate!
        item = PortfolioItem.only_deleted.find(params[:id])
        authorize item, :restore?

        present item.restore, with: Entities::PortfolioItem
      end
    end
  end
end
