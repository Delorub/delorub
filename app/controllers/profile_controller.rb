class ProfileController < ApplicationController
  helper_method :create_profile_props

  def new
    @profile = CreateProfileForm.new Profile.new
  end

  private

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
