class ProfilesController < ApplicationController
  inherit_resources

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

  def index
    fetch_category
  end

  private

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
