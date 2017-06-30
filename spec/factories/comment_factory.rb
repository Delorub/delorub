FactoryGirl.define do
  factory :comment do
    user
    association :commentable, factory: :portfolio_item
    text Faker::Lorem.sentences(2)
  end
end
