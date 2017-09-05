class ProfilesController < ApplicationController
  inherit_resources

  helper_method :all_categories, :active_cities
  before_action :category_present?, only: [:index]
  before_action :city_present?, only: [:index]
  before_action :city_settings, only: [:index]

  decorates_assigned :profiles, :profile

  def new
    authorize Profile
    run Profile::Operation::Present
  end

  def create
    run Profile::Operation, profile_params do |result|
      sign_in result['sign_in_new_user'] if result['sign_in_new_user']
      return redirect_to profile_path(result['model']), notice: 'Профиль зарегистрирован'
    end

    render 'new'
  end

  private

    def all_categories
      @all_categories = Category.roots.includes(:children).order(:position)
    end

    def active_cities
      @active_cities = City.active
    end

    def category_present?
      return unless params[:category_id]
      @category = Category.friendly.where(slug: params[:category_id]).first
      render_page_not_found if @category.blank?
    end

    def city_present?
      return unless params[:city_code]
      @city = City.where(code: params[:city_code]).first
      not_found if @city.blank?
    end

    def city_settings
      return unless @city && @category
      @city_settings = @city.city_categories.with_settings_type(:profile).where(category_id: @category.id).first
    end

    def end_of_association_chain
      ProfileQuery.new(collection: super, category: @category, current_user: current_user, page: params[:page],
                       direction: params[:direction_created], city: @city).perform
    end

    def profile_params
      params.require(:profile).permit!
    end

    def fetch_category
      @category = Category.friendly.find params[:category_id] if params[:category_id]
    end
end
