FactoryGirl.define do
  factory :notification do
    message { Faker::Lorem.word }
    state { Faker::Lorem.word }
    association :user, factory: :user
    params { Faker::Lorem.words }
    notifiable_type User
    notifiable_id 1
  end
end
