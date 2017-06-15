FactoryGirl.define do
  factory :profile do
    user
    association :place, factory: :city_place

    trait :reindex do
      after(:create) do |profile, _evaluator|
        profile.reindex(refresh: true)
      end
    end
  end
end
