class PlaceQuery
  attr_reader :user

  def initialize user
    @user = user
  end

  def popular_places
    city_of_current_user = Place.where(id: user.profile.place.id)
    all_cities = Place.only_cities
    (city_of_current_user + all_cities).uniq
  end
end
