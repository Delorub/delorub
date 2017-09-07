class MainController < ApplicationController
  helper_method :random_categories, :main_categories

  def index; end

  private

    def random_categories
      Category.order('RANDOM()').first(2)
    end

    def main_categories
      Category.main.includes(:children).order(:position)
    end
end
