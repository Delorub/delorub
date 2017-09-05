# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  code       :string
#  name       :string
#  active     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_cities_on_code  (code)
#

class City < ApplicationRecord
  has_many :city_categories
  has_many :categories, through: :city_categories

  has_many :profiles
  has_many :tasks

  validates :name, :code, presence: true, length: { maximum: 250 }
  validates :code, uniqueness: true

  scope :active, -> { where(active: true) }
end
