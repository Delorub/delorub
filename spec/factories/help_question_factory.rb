FactoryGirl.define do
  factory :help_question do
    name Faker::Name.first_name
    email Faker::Internet.email
    content Faker::Lorem.sentences(2)
  end
end
