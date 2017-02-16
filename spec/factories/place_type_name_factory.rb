FactoryGirl.define do
  factory :place_type_name do
    name { Faker::Lorem.word }
    full_name { "Full #{name}" }
    alt_name { "Alt. #{name}" }

    after_place_name true
  end
end
