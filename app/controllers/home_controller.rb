class HomeController < ApplicationController
  def index
    @categories = Category.all
    render 'false'
  end
end
