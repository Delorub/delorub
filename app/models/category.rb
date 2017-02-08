class Category < ActiveRecord::Base
  include Searchable::Category
  
  mount_uploader :photo, CategoryPhotoUploader
  acts_as_nested_set counter_cache: :children_count

  validates :title, presence: true

  def form_count
    0
  end

  def master_count
    0
  end
end
