# == Schema Information
#
# Table name: profiles
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  work_type     :string
#  pay_type      :string
#  have_car      :boolean
#  have_truck    :boolean
#  about         :text
#  place_id      :integer
#  place_lat     :float
#  place_long    :float
#  place_address :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Profile < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :specializations

  enumerize :work_type, in: [:single, :company, :team]
  enumerize :pay_type, in: [:cash, :emoney, :card, :other]
  enumerize :car_type, in: [:passenger, :truck, :none]

  validates :user_id, presence: true, if: :active?
end
