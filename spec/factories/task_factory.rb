FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| Faker::Commerce.department(1) }
    sequence(:description) { |n| Faker::Lorem.paragraph }

    price_type :exact
    date_type :actual

    user
    category
  end
end
