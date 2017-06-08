FactoryGirl.define do
  factory :vacancy do
    title Faker::Lorem.word
    small_description Faker::Lorem.sentence
    description Faker::Lorem.sentences(4)
  end
end
