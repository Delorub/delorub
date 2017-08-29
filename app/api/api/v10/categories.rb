class Api::V10::Categories < ApplicationAPI
  namespace :categories do
    desc 'Search categories'
    params do
      requires :search, type: String, desc: 'Search'
    end
    post do
      result = SearchCategoriesService.new(params: params).perform
      present result, with: Entities::Category
    end
  end
end
