# == Schema Information
#
# Table name: profiles
#
#  id                          :integer          not null, primary key
#  user_id                     :integer          not null
#  work_type                   :string
#  have_car                    :boolean
#  about                       :text
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  price_type                  :string
#  price_hourly                :integer
#  price_project               :integer
#  have_instrument             :boolean          default(FALSE)
#  can_departure               :boolean          default(FALSE)
#  working_all_time            :boolean          default(FALSE)
#  working_days                :string
#  working_hours_from          :integer
#  working_hours_to            :integer
#  rating_votes_count          :integer
#  rating_votes_sum            :integer
#  rating                      :float
#  notifications_email_enabled :boolean          default(TRUE)
#

class Profile < ApplicationRecord
  extend Enumerize
  include Searchable::Profile

  belongs_to :user

  has_and_belongs_to_many :categories

  has_many :portfolio_items
  has_many :certificates

  accepts_nested_attributes_for :categories

  enumerize :price_type, in: [:hourly, :project]
  enumerize :working_days,
    in: { monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 0 },
    multiple: true

  validates :user_id, presence: true

  delegate :name, to: :user

  scope :by_category,
    ->(category) { joins(:categories).where(categories: { id: category.id }) }
  scope :by_category_with_descendants,
    ->(category) { joins(:categories).where(categories: { id: category.self_and_descendants_ids }) }
end
