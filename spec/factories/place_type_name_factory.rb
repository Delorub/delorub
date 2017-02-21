FactoryGirl.define do
  factory :place_type_name do
    name { Faker::Lorem.word }
    full_name { "Full #{name}" }
    alt_name { "Alt. #{name}" }

    after_place_name true

    factory :region_place_type_name do
      name 'обл.'
    end

    factory :city_place_type_name do
      name 'г.'
    end

    factory :street_place_type_name do
      name 'ул.'
    end
  end
end
