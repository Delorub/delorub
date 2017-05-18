# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  title      :string
#  price      :integer
#  price_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Service < ActiveRecord::Base
  extend Enumerize

  enumerize :price_type, in: [:one_time, :hour, :day, :month]

  belongs_to :profile

  validates :profile, presence: true
end
