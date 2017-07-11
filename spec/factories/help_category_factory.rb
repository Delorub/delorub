# == Schema Information
#
# Table name: help_categories
#
#  id       :integer          not null, primary key
#  title    :string
#  position :integer
#

FactoryGirl.define do
  factory :help_category do
    title { Faker::Lorem.word }
  end
end
