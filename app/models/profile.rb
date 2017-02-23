# == Schema Information
#
# Table name: profiles
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  work_type     :string(255)
#  pay_type      :string(255)
#  have_car      :boolean
#  have_truck    :boolean
#  about         :text(65535)
#  place_id      :integer
#  place_lat     :float(24)
#  place_long    :float(24)
#  place_address :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Profile < ActiveRecord::Base
  extend Enumerize

  belongs_to :user

  enumerize :work_type, in: [:single, :company, :team]
  enumerize :pay_type, in: [:cash, :emoney, :card, :other]
  enumerize :car_type, in: [:passenger, :truck, :none]

  validates :user_id, presence: true
end
