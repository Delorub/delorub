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
      Place.only_cities
    end
end
