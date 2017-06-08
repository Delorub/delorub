class ProfilesController < ApplicationController
  inherit_resources

  helper_method :create_profile_form_props, :current_url

  def new
    @form = CreateProfileForm.new Profile.new(place_id: 1)
  end

  def index
    fetch_category
  end

  private

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

    def create_profile_form_props
      {
        form_action: profiles_path,
        create_profile: Entities::CreateProfileForm.represent(@form),
        categories: Entities::Category.represent(Category.all)
      }
    end
end
