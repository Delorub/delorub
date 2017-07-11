# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  photo      :string
#

FactoryGirl.define do
  factory :news do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
