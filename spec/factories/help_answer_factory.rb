FactoryGirl.define do
  factory :help_answer do
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentence }
    association :help_category, factory: :help_category
  end
end
