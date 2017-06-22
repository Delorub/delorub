FactoryGirl.define do
  factory :comment do
    user
    association :commentable, factory: :portfolio_item
    text 'text'
  end
end
