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

FactoryGirl.define do
  factory :service do
    profile
  end
end
