FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.unique.email }
    sequence(:phone) { |n| Phony.format("7999#{(1111111 + n).to_s}") }
    phone_confirmed true

    password { generate :password }
    password_confirmation(&:password)

    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }

    factory :editor do
      association :permission, factory: :editor_user_permission
    end

    factory :admin do
      association :permission, factory: :admin_user_permission
    end

    factory :superadmin do
      association :permission, factory: :superadmin_user_permission
    end
  end
end
