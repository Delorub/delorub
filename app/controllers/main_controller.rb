class MainController < ApplicationController
  skip_before_action :show_global_container

  def index
    @categories = Category.roots
  end
end
