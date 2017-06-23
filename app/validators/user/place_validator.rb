class User::PlaceValidator < ActiveModel::Validator
  # TODO delete if unused
  def validate record
    city = Place.only_cities.find_by(id: record.place_id)
    record.errors.add(:place_id, 'must be a city') if city.blank?
  end
end
