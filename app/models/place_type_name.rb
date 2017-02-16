# == Schema Information
#
# Table name: place_type_names
#
#  id               :integer          not null, primary key
#  level            :integer
#  code             :integer
#  name             :string(255)
#  full_name        :string(255)
#  alt_name         :string(255)
#  after_place_name :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class PlaceTypeName < ActiveRecord::Base
  def display_name
    if alt_name
      alt_name
    else
      name
    end
  end

  def search_string
    name_variations.join(' ')
  end

  def name_variations
    [name, full_name, alt_name].compact
  end
end
