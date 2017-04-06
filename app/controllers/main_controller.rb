class MainController < ApplicationController
  def index
    @categories = Category.all
  end
end
