class Api::V10::Searches < ApplicationAPI
  helpers ::Grape::AuthHelpers

  helpers do
    def place_search
      return popular_places if params[:query].blank?

      PlaceSearch.new(
        query: params[:query],
        page: params[:page],
        per_page: params[:per_page],
        type: params[:type]
      ).all
    end

    def popular_places
      Place::PopularQuery.new(current_user).perform
    end
  end

  namespace :searches do
    desc 'Search places', is_array: true, entity: Entities::Place
    params do
      optional :query, type: String, desc: 'Search query'
      optional :page, type: Integer, desc: 'Page number', default: 1
      optional :per_page, type: Integer, desc: 'Per Page', default: 20
      optional :type, type: String, desc: 'Type of place', values: ['city']
    end
    get :place do
      authenticate_user!
      present :query, params[:query]
      present :type, params[:type]
      present :places, place_search, with: Entities::Place
    end
  end
end
