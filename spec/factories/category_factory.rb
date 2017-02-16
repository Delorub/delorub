FactoryGirl.define do
  factory :category do
    sequence(:title) { |n| Faker::Commerce.department(1) }
  end
end
