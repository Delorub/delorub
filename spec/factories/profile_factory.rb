# == Schema Information
#
# Table name: profiles
#
#  id                 :integer          not null, primary key
#  user_id            :integer          not null
#  about              :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  price_project      :integer
#  rating_votes_count :integer
#  rating_votes_sum   :integer
#  rating             :float
#  birthday           :date
#  city_name          :string
#  city_id            :integer
#
# Indexes
#
#  index_profiles_on_city_id  (city_id)
#

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
