# == Schema Information
#
# Table name: main_categories_profiles
#
#  id               :integer          not null, primary key
#  main_category_id :integer
#  profile_id       :integer
#  description      :text
#
# Indexes
#
#  main_categories_profiles_category_and_profile  (main_category_id,profile_id) UNIQUE
#

class MainCategoriesProfile < ApplicationRecord
  belongs_to :main_category, class_name: 'Category'
  belongs_to :profile
end
