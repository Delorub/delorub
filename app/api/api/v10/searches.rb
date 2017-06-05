class Api::V10::Searches < Grape::API
  helpers do
    def place_search
      return popular_places if params[:query].blank?

      PlaceSearch.new \
        query: params[:query],
        page: params[:page],
        per_page: params[:per_page],
        type: params[:type]
    end

    def popular_places
      Place.limit(params[:per_page]).order('level ASC')
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
      present :query, params[:query]
      present :type, params[:type]
      present :places, place_search.all, with: Entities::Place
    end
  end
end
