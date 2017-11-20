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

FactoryGirl.define do
  factory :portfolio_item, class: PortfolioItem do
    portfolio
    file do
      Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'support', 'portfolio_item', 'files', 'image.png')))
    end
  end
end
