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
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#

class Category < ActiveRecord::Base
  include FriendlyId
  include Searchable::Category

  mount_uploader :photo, CategoryPhotoUploader
  acts_as_nested_set counter_cache: :children_count
  acts_as_list scope: [:parent_id], top_of_list: 0

  validates :title, :slug, presence: true
  validates :slug, uniqueness: true

  friendly_id :title, use: :slugged

  def form_count
    0
  end

  def master_count
    0
  end
end
