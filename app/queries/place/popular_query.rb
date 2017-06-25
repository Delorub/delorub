class Place::PopularQuery
  attr_reader :user

  def initialize user
    @user = user
  end

  def perform
    ([city_of_current_user] + all_cities).compact.uniq
  end

  private

    def city_of_current_user
      return if user.blank?
      user.place
    end

    def all_cities
      Place.where { is_region_center == true }.limit(100)
    end
end
