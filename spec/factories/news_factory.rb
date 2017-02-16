FactoryGirl.define do
  factory :news do
    name { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
