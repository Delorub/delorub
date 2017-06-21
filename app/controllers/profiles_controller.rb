class ProfilesController < ApplicationController
  inherit_resources

  helper_method :create_profile_form_props, :current_url

  def new
    authorize build_profile, :create?
    @form = CreateProfileForm.new profile: build_profile, user: current_user
  end

  def create
    authorize build_profile, :create?
    @form = CreateProfileForm.new profile: Profile.new(user: current_user).decorate, user: current_user.dup

    if @form.validate create_profile_params
      unless user_signed_in?
        store_form_to_session
        return redirect_to new_user_session_path, notice: 'Отлично! Для завершения нужно войти либо зарегистрироваться'
      end
      creator = Profile::FormCreator.new(@form)
      creator.perform
      if creator.model[:profile].persisted?
        check_after_profile_creation creator.model[:profile]
        return redirect_to @after_profile_creation_creator.path if @after_profile_creation_creator.present?
        return redirect_to profile_path(creator.model[:profile]), notice: 'Анкета создана'
      end
      flash.now.alert = creator.last_error
    else
      flash.now.alert = @form.errors
    end

    render 'new'
  end

  def edit
    @form = CreateProfileForm.new profile: resource.decorate, user: resource.user
  end

  def index
    fetch_category
  end

  private

    def build_profile
      Profile.new(user: current_user.dup)
    end

    def check_after_profile_creation profile
      return if session[:after_profile_creation].blank?
      @after_profile_creation_creator = AfterProfileCreationCreator.new \
        session[:after_profile_creation]['type'],
        session[:after_profile_creation]['data'],
        profile
      @after_profile_creation_creator.perform
    end

    def current_url category:
      if category
        category_profiles_path(category_id: category)
      else
        profiles_path
      end
    end

    def fetch_category
      @category = Category.friendly.find params[:category_id] if params[:category_id]
    end

    def create_profile_params
      params.require(:create_profile).permit(:main_category_id, :temporary_photo_id,
        :about, :place_id, :notifications_type, :paid_functions, :have_car, :have_instrument, :can_departure,
        :price_type, :working_hours_from, :working_hours_to, :price_hourly, :price_project,
        categories: [:id], working_days: {})
    end

    def create_profile_form_props
      {
        form_action: profiles_path,
        create_profile: Entities::CreateProfileForm.represent(@form),
        all_categories: Entities::Category.represent(Category.all)
      }
    end
end
