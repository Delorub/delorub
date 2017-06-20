class Api::V10::PortfolioItems < ApplicationAPI
  helpers ::Grape::AuthHelpers

  helpers do
    def portfolio_item
      PortfolioItem.find(params[:id])
    end
  end

  resource :portfolio_items do
    route_param :id do
      resources :comments do
        desc 'Get comments for particular profile item'
        get do
          portfolio_item.comments
        end

        desc 'Create comment for profile item'
        params do
          optional :parent_id, type: Integer, desc: 'Id of parent comment'
          requires :text, type: String, desc: 'Comment'
        end
        post do
          portfolio_item.comments.create(
            parent_id: params[:parent_id],
            text: params[:text],
            user_id: current_user.id
          )
        end
      end
    end
  end
end
