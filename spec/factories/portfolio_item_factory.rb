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

FactoryGirl.define do
  factory :portfolio_item do
    profile
    file do
      Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'support', 'portfolio_item', 'files', 'image.png')))
    end
  end
end
