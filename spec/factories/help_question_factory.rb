# == Schema Information
#
# Table name: help_questions
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  content    :text
#  reply      :text
#  answered   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#  replied_at :datetime
#

FactoryGirl.define do
  factory :help_question do
    name Faker::Name.first_name
    email Faker::Internet.email
    content Faker::Lorem.sentences(2)
  end
end
