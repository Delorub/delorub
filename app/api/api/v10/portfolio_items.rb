class Api::V10::PortfolioItems < ApplicationAPI
  helpers ::Grape::AuthHelpers
  helpers ::Grape::PunditHelpers

  helpers do
    def find_portfolio_item
      PortfolioItem.find(params[:id])
    end

    def find_comment
      find_portfolio_item.comments.find(params[:comment_id])
    end

    def destroy comment
      Comment::DestroyService.new(comment).perform
    end
  end

  resource :portfolio_items do
    route_param :id do
      resources :comments do
        desc 'Get comments for particular profile item'
        get do
          find_portfolio_item.comments
        end

        desc 'Create comment for profile item'
        params do
          optional :parent_id, type: Integer, desc: 'Id of parent comment'
          requires :text, type: String, desc: 'Comment'
        end
        post do
          find_portfolio_item.comments.create(
            parent_id: params[:parent_id],
            text: params[:text],
            user_id: current_user.id
          )
        end

        desc 'Update comment of profile item'
        params do
          optional :parent_id, type: Integer, desc: 'Id of parent comment'
          requires :text, type: String, desc: 'Comment'
        end
        patch ':comment_id' do
          authenticate!
          comment = find_comment
          authorize comment, :update?
          comment.update(
            parent_id: params[:parent_id],
            text: params[:text]
          )
          present comment, with: Entities::Comment
        end

        desc 'Destroy comment of profile item'
        delete ':comment_id' do
          authenticate!
          comment = find_comment
          authorize comment, :destroy?
          destroy comment
          status 200
        end
      end
    end
  end
end
