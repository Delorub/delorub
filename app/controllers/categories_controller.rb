class CategoriesController < ApplicationController
  include Pundit

  def search
    data_search = CategoryQuery.new(search_params: params[:search]).search
    render json: { result: true, categories: data_search }
  end
end
