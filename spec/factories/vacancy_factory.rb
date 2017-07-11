# == Schema Information
#
# Table name: vacancies
#
#  id                :integer          not null, primary key
#  title             :string
#  small_description :text
#  description       :text
#  position          :integer
#  archive           :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :vacancy do
    title Faker::Lorem.word
    small_description Faker::Lorem.sentence
    description Faker::Lorem.sentences(4)
  end
end
