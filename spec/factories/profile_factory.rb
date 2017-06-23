FactoryGirl.define do
  factory :profile do
    user

    trait :reindex do
      after(:create) do |profile, _evaluator|
        profile.reindex(refresh: true)
      end
    end
  end
end
