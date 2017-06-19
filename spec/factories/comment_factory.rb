FactoryGirl.define do
  factory :comment do
    user
    commentable_id 1
    commentable_type 'PortfolioItem'
    text 'text'
  end
end
