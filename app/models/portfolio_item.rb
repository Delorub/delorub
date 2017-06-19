# == Schema Information
#
# Table name: portfolio_items
#
#  id         :integer          not null, primary key
#  title      :string
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

  belongs_to :profile

  validates :profile_id, :title, presence: true

  has_many :comments, as: :commentable
end
