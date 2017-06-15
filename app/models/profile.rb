# == Schema Information
#
# Table name: profiles
#
#  id                          :integer          not null, primary key
#  user_id                     :integer          not null
#  work_type                   :string
#  have_car                    :boolean
#  about                       :text
#  place_id                    :integer
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
  belongs_to :place

  has_and_belongs_to_many :categories

  accepts_nested_attributes_for :categories

  enumerize :pay_type, in: [:hourly]
  enumerize :car_type, in: [:passenger, :none]

  validates_with Profile::PlaceValidator
  validates :user_id, presence: true

  delegate :name, to: :user
end
