# == Schema Information
#
# Table name: portfolio_items
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_portfolio_items_on_profile_id  (profile_id)
#

class PortfolioItem < ApplicationRecord
  mount_uploader :file, PortfolioItemUploader

  belongs_to :profile, optional: true

  validates :file, presence: true

  has_many :comments, as: :commentable
end
