# == Schema Information
#
# Table name: city_categories
#
#  id            :integer          not null, primary key
#  city_id       :integer
#  category_id   :integer
#  settings      :text
#  settings_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_city_categories_on_category_id  (category_id)
#  index_city_categories_on_city_id      (city_id)
#

class CityCategory < ApplicationRecord
  extend Enumerize

  belongs_to :city
  belongs_to :category

  serialize :settings, OpenStruct
  enumerize :settings_type, in: [:task, :profile], scope: true
end
