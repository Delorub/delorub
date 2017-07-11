# == Schema Information
#
# Table name: help_answers
#
#  id               :integer          not null, primary key
#  help_category_id :integer
#  title            :string
#  content          :text
#  synonyms         :text
#  position         :integer
#

FactoryGirl.define do
  factory :help_answer do
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentence }
    association :help_category, factory: :help_category
  end
end
