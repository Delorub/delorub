class Api::V10::Profiles < ApplicationAPI
  namespace :profiles do
    namespace :order do
      desc 'Order profiles by params'
      post do
        data = params['query']
        result = ProfileQuery.new(collection: Profile.all,
                                  category: Category.friendly.find_by(slug: data[:category_id]),
                                  page: data[:page],
                                  direction: data[:direction_created],
                                  place: Place.only_cities.friendly.find_by(slug: data[:city_code])).perform

        present result, with: Entities::Profile
      end
    end
  end
end
