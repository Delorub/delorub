class MainController < ApplicationController
  helper_method :random_categories, :main_categories

  def index; end

  def robots
    robots = File.read(Rails.root + "config/robots/#{Rails.env}.txt")
    render :plain => robots, :layout => false, :content_type => 'text/plain'
  end

  private

    def random_categories
      Category.order('RANDOM()').first(2)
    end

    def main_categories
      Category.main.includes(:children).order(:position)
    end
end
