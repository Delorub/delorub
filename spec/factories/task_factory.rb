FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| Faker::Commerce.department(1) }

    user
    category
  end
end
