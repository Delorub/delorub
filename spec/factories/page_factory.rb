# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  slug       :string
#  content    :text
#  draft      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :page do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    slug { Faker::Internet.slug }
    draft false

    factory :page_draft do
      draft true
    end

    factory :page_rules do
      title { 'Пользовательское соглашение' }
      slug { 'rules' }
    end
  end
end
