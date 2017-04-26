class CreateProfileController < ApplicationController
  helper_method :create_profile_props

  def index
    @profile = CreateProfileForm.new Profile.new
  end

  private

    def create_profile_props
      {
        categories: Category.all.map { |e|
          {
            id: e.id,
            title: e.title,
            parent_id: e.parent_id
          }
        }
      }
    end
end
