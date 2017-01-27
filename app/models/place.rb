class Place < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  include Searchable::Place

  belongs_to :place_type_name
  belongs_to :parent_place, class_name: "Place"
  belongs_to :region_place, class_name: "Place"
  
  enumerize :place_type, in: { region: 1, district: 2, city: 3, locality: 4, street: 5, house: 6 }, i18n_scope: 'place_type'

  before_save :update_full_name

  def display_name
    if place_type_name
      if place_type_name.after_place_name
        "#{name} #{place_type_name.display_name}"
      else
        "#{place_type_name.display_name} #{name}"
      end
    else
      name
    end
  end

  private

    def get_full_name
      if parent_place
        "#{display_name}, #{parent_place.full_name}"
      else
        display_name
      end
    end

    def update_full_name
      self.full_name = get_full_name
    end
end
