class ProfilesController < ApplicationController
  inherit_resources

  helper_method :create_profile_form_props, :current_url
  before_action :get_categories, only: [:index]
  before_action :category_present?, only: [:index]

  def index
    @profiles = ProfileQuery.new(category: @category, current_user: current_user).all(params[:page])
  end

  def new
    run Profile::Operation::Present
  end

  def create
    run Profile::Operation, profile_params do |result|
      sign_in result['sign_in_new_user'] if result['sign_in_new_user']
      return redirect_to profile_path(result['model']), notice: 'Профиль зарегистрирован'
    end

    render 'new'
  end

  def edit
    authorize resource, :edit?
    @form = CreateProfileForm.new profile: resource.decorate, user: resource.user
  end

  def update
    authorize resource, :edit?
    @form = CreateProfileForm.new profile: resource.decorate, user: resource.user

    if @form.validate create_profile_params
      creator = Profile::FormCreator.new(@form)
      creator.perform
      if creator.model[:profile].persisted?
        return redirect_to profile_path(creator.model[:profile]), notice: 'Профиль отредактирован'
      end
      flash.now.alert = creator.last_error
    else
      flash.now.alert = @form.errors
    end

    render 'edit'
  end

  private

    def get_categories
      @categories = Category.roots.includes(:children).order(:position)
    end

    def category_present?
      if params[:category_id]
        category = Category.friendly.where(slug: params[:category_id]).first
        render_page_not_found if category.blank?
        @category = category.decorate
      end
    end

    def current_user_or_new
      user_signed_in? ? current_user : User.new
    end

    def end_of_association_chain
      ProfileQuery.new(collection: super, category: @category, current_user: current_user).perform
    end

    def profile_params
      params.require(:profile).permit!
    end

    def fetch_category
      @category = Category.friendly.find params[:category_id] if params[:category_id]
    end
end
