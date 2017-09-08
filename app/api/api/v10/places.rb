class Api::V10::Places < ApplicationAPI
  namespace :regions do
    desc 'Search regions'
    post do
      result = Place.by_search_in(params[:query], 'region')
      present result, with: Entities::Region
    end
  end

  namespace :cities do
    desc 'Search cities'
    post do
      result = Place.by_search_in(params[:query], 'city')
      present result, with: Entities::City
    end
  end
end
