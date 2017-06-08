class MainController < ApplicationController
  skip_before_filter :show_global_container

  def index
    @categories = Category.roots
  end
end
