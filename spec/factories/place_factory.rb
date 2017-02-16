FactoryGirl.define do
  factory :place do
    name { Faker::Lorem.word }
    full_name { "Full name of #{name}" }

    factory :region_place do
      name { Faker::Address.state }
      level 1
      place_type :region
      association :place_type_name, :region_place_type_name
    end

    factory :city_place do
      name { Faker::Address.city }
      level 2
      place_type :city
      association :parent_place, factory: :region_place
      association :place_type_name, :city_place_type_name
    end

    factory :street_place do
      name { Faker::Address.street_name }
      level 3
      place_type :street
      association :parent_place, factory: :city_place
      association :place_type_name, :street_place_type_name
    end
  end
end
