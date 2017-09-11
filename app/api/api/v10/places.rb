class Api::V10::Places < ApplicationAPI
  namespace :regions do
    desc 'Search regions'
    post do
      result = Place.by_search_in_types(params[:query], 'region')
      present result, with: Entities::Places::Region
    end
  end

  namespace :cities do
    desc 'Search cities'
    post do
      result = Place.by_search_in_types(params[:query], 'city')
      present result, with: Entities::Places::City
    end
  end
end
