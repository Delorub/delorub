FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email }
    password { generate :password }
    password_confirmation { |u| u.password }

    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
  end
end
