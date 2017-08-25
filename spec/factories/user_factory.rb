# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  provider               :string           default("email"), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  middle_name            :string
#  phone                  :string
#  email                  :string
#  birthday               :date
#  profile_id             :integer
#  free_tasks_published   :integer          default(0), not null
#  free_replies_published :integer          default(0), not null
#  balance                :decimal(10, 2)   default(0.0), not null
#  photo                  :string
#  phone_confirmed        :boolean
#  created_at             :datetime
#  updated_at             :datetime
#  access_token           :string
#  place_id               :integer
#  first_name             :string
#  last_name              :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_place_id              (place_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.unique.email }
    sequence(:phone) { |n| Phony.format("7999#{1_234_567 + n}") }
    phone_confirmed true
    balance 100

    association :place, factory: :city_place

    password { generate :password }
    password_confirmation(&:password)

    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }

    factory :editor do
      association :permission, factory: :editor_user_permission
    end

    factory :admin do
      association :permission, factory: :admin_user_permission
    end

    factory :superadmin do
      association :permission, factory: :superadmin_user_permission
    end

    trait :reindex do
      after(:create) do |user, _evaluator|
        user.reindex(refresh: true)
      end
    end
  end
end
