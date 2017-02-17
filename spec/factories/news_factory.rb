FactoryGirl.define do
  factory :news do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
