FactoryGirl.define do
  factory :place do
    name { Faker::Lorem.word }
    full_name { "Full name of #{name}" }

    factory :region_place do
      name { Faker::Address.state }
      level 1
      place_type :region
      association :place_type_name, factory: :region_place_type_name
    end

    factory :district_place do
      name { Faker::Address.state_abbr }
      level 2
      place_type :district
      association :place_type_name, factory: :district_place_type_name
    end

    factory :city_place do
      name { Faker::Address.city }
      level 3
      place_type :city
      association :place_type_name, factory: :city_place_type_name
    end

    factory :locality_place do
      name { Faker::Address.country }
      level 4
      place_type :locality
      association :place_type_name, factory: :locality_place_type_name
    end

    factory :street_place do
      name { Faker::Address.street_name }
      level 5
      place_type :street
      association :place_type_name, factory: :street_place_type_name
    end

    factory :house_place do
      name { Faker::Address.building_number }
      level 6
      place_type :house
      association :place_type_name, factory: :house_place_type_name
    end

    trait :reindex do
      after(:create) do |place, _evaluator|
        place.reindex(refresh: true)
      end
    end
  end
end
