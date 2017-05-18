class ProfilesController < ApplicationController
  inherit_resources

  helper_method :create_profile_props, :current_url

  def new
    @profile = CreateProfileForm.new Profile.new
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

    def create_profile_props
      {
        categories: Category.all.map { |e|
          {
            id: e.id,
            title: e.title,
            parent_id: e.parent_id,
            photo_thumb_url: e.photo.thumb.url
          }
        }
      }
    end
end
