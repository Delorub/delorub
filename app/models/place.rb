# == Schema Information
#
# Table name: places
#
#  id                 :integer          not null, primary key
#  fias_aoguid        :string(255)
#  name               :string(255)
#  full_name          :string(255)
#  level              :integer
#  place_type         :integer
#  place_type_name_id :integer
#  parent_place_id    :integer
#  region_place_id    :integer
#  is_region_center   :boolean
#  is_center          :boolean
#  custom             :boolean
#

class Place < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  include Searchable::Place

  belongs_to :place_type_name
  belongs_to :parent_place, class_name: 'Place'
  belongs_to :region_place, class_name: 'Place'

  enumerize :place_type, in: { region: 1, district: 2, city: 3, locality: 4, street: 5, house: 6 }, i18n_scope: 'place_type'

  before_save :update_full_name

  def display_name
    if place_type_name
      with_place_name
    else
      name
    end
  end

  def with_place_name place_name = nil
    place_name ||= place_type_name.display_name
    if place_type_name.after_place_name
      "#{name} #{place_name}"
    else
      "#{place_name} #{name}"
    end
  end

  def search_name
    if place_type_name
      place_type_name.name_variations.map do |place_name|
        with_place_name place_name
      end.join(' ')
    else
      name
    end
  end

  def search_string
    if parent_place
      "#{search_name} #{parent_place.search_string}"
    else
      search_name
    end
  end

  private

    def render_full_name
      if parent_place
        "#{display_name}, #{parent_place.full_name}"
      else
        display_name
      end
    end

    def update_full_name
      self.full_name = render_full_name
    end
end
