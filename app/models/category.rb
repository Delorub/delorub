# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  parent_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  lft            :integer
#  rgt            :integer
#  depth          :integer
#  children_count :integer
#  photo          :string(255)
#  position       :integer
#

class Category < ActiveRecord::Base
  include Searchable::Category

  mount_uploader :photo, CategoryPhotoUploader
  acts_as_nested_set counter_cache: :children_count
  acts_as_list

  validates :title, :photo, presence: true

  def form_count
    0
  end

  def master_count
    0
  end
end
