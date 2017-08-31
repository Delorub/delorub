class Api::V10::Categories < ApplicationAPI
  namespace :categories do
    desc 'Search categories'
    post do
      result = SearchCategoriesService.new(query: params[:query]).perform
      present result, with: Entities::Category
    end
  end
end
