# == Schema Information
#
# Table name: portfolios
#
#  id          :integer          not null, primary key
#  profile_id  :integer
#  name        :string
#  description :text
#  cover       :string
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_portfolios_on_deleted_at  (deleted_at)
#  index_portfolios_on_profile_id  (profile_id)
#

class Portfolio < ApplicationRecord
  acts_as_paranoid
  mount_uploader :cover, PortfolioUploader

  belongs_to :profile
  has_one :user, through: :profile

  has_many :portfolio_items
end
