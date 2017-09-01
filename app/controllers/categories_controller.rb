class CategoriesController < ApplicationController
  include Pundit

  def index
    @categories = Category.roots.includes(:children).order(:position)
  end
end
