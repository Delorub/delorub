# == Schema Information
#
# Table name: portfolio_items
#
#  id           :integer          not null, primary key
#  portfolio_id :integer
#  file         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  description  :text
#  deleted_at   :datetime
#
# Indexes
#
#  index_portfolio_items_on_portfolio_id  (portfolio_id)
#

class PortfolioItem < ApplicationRecord
  acts_as_paranoid
  mount_uploader :file, PortfolioItemUploader

  belongs_to :portfolio, optional: true

  validates :file, presence: true
end
