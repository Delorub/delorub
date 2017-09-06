# == Schema Information
#
# Table name: place_categories_settings
#
#  id            :integer          not null, primary key
#  place_id      :integer
#  category_id   :integer
#  settings      :text
#  settings_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_place_categories_settings_on_category_id  (category_id)
#  index_place_categories_settings_on_place_id     (place_id)
#

class PlaceCategoriesSetting < ApplicationRecord
  extend Enumerize

  belongs_to :place
  belongs_to :category

  serialize :settings, OpenStruct
  enumerize :settings_type, in: [:task, :profile], scope: true
end
