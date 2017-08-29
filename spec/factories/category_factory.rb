# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  title          :string
#  parent_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  lft            :integer
#  rgt            :integer
#  depth          :integer
#  children_count :integer
#  photo          :string
#  position       :integer
#  slug           :string
#  settings       :text
#  description    :text
#  main           :boolean          default(FALSE)
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#

FactoryGirl.define do
  factory :category do
    sequence(:title) { |n| Faker::Commerce.department(1) }
  end
end
