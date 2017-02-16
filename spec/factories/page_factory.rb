FactoryGirl.define do
  factory :page do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    slug { Faker::Internet.slug }
    draft false

    factory :news_draft do
      draft true
    end
  end
end
