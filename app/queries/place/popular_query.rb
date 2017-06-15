class Place::PopularQuery
  attr_reader :profile

  def initialize profile
    @profile = profile
  end

  def perform
    city_of_current_profile = Place.where(id: profile.place.id)
    all_cities = Place.only_cities
    (city_of_current_profile + all_cities).uniq
  end
end
