class ProfilesController < ApplicationController
  inherit_resources

  helper_method :task_form_props, :create_profile_form_props, :current_url, :all_categories
  before_action :category_present?, only: [:index]

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

    def all_categories
      @all_categories = Category.roots.includes(:children).order(:position)
    end

    def category_present?
      return unless params[:category_id]
      @category = Category.friendly.where(slug: params[:category_id]).first
      render_page_not_found if @category.blank?
    end

    def end_of_association_chain
      ProfileQuery.new(collection: super, category: @category, current_user: current_user, page: params[:page],
                       direction: params[:direction_created]).perform
    end

    def profile_params
      params.require(:profile).permit!
    end

    def fetch_category
      @category = Category.friendly.find params[:category_id] if params[:category_id]
    end
end
