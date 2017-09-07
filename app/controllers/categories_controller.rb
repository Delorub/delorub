class CategoriesController < ApplicationController
  include Pundit

  def index
    @categories = Category.roots.includes(:children).except(:order).order(:position)
  end
end
