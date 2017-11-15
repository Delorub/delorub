# == Schema Information
#
# Table name: portfolio_temporary_covers
#
#  id         :integer          not null, primary key
#  cover      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Portfolio::TemporaryCover < ApplicationRecord
  mount_uploader :cover, PortfolioUploader
end
