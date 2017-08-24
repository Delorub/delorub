class ProfilesController < ApplicationController
  inherit_resources

  def new
    authorize Profile
    run Profile::Operation::Present
  end

  def create
    authorize Profile
    run Profile::Operation, profile_params do |result|
      sign_in result['sign_in_new_user'] if result['sign_in_new_user']
      return redirect_to profile_path(result['model']), notice: 'Профиль зарегистрирован'
    end

    render 'new'
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
