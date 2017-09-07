# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  user_id            :integer          not null
#  about              :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  price_project      :integer
#  rating_votes_count :integer
#  rating_votes_sum   :integer
#  rating             :float
#  birthday           :date
#  city_name          :string
#  place_id           :integer
#
# Indexes
#
#  index_profiles_on_place_id  (place_id)
#

class Profile < ApplicationRecord
  include Searchable::Profile

  belongs_to :user
  belongs_to :place

  has_and_belongs_to_many :categories

  has_many :main_categories_profiles
  has_many :main_categories, through: :main_categories_profiles

  has_many :portfolio_items
  has_many :certificates

  validates :user_id, presence: true

  scope :by_category,
    ->(category) { joins(:categories).where(categories: { id: category.id }) }

  scope :by_main_category,
    ->(category) { joins(:main_categories).where(categories: { id: category.id }) }

  scope :by_category_with_descendants,
    ->(category) { joins(:categories).where(categories: { id: category.self_and_descendants_ids }) }
end
