FactoryGirl.define do
  factory :reply do
    task
    user
    content Faker::Lorem.sentences(2)
  end
end
