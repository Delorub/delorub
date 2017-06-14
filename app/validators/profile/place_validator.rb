class Profile::PlaceValidator < ActiveModel::Validator
  def validate record
    city = Place.only_cities.find_by(id: record.place_id)
    record.errors.add(:place_id, 'must be a city') unless city.present?
  end
end
