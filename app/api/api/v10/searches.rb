class Api::V10::Searches < Grape::API
  helpers do
    def place_search
      PlaceSearch.new \
        query: params[:query],
        page: params[:page],
        per_page: params[:per_page]
    end
  end

  namespace :searches do
    desc 'Search places', is_array: true, entity: Entities::Place
    params do
      requires :query, type: String
      optional :page, type: Integer, desc: 'Page number', default: 1
      optional :per_page, type: Integer, desc: 'Per Page', default: 20
    end
    get :place do
      present :query, params[:query]
      present :places, place_search.all, with: Entities::Place
    end
  end
end
