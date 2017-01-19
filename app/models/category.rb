class Category < ActiveRecord::Base
  include Searchable::Category
  
  acts_as_nested_set counter_cache: :children_count

  validates :title, presence: true
  #validates :depth, numericality: { less_than_or_equal_to: 2 }
  
  def form_count
    0
  end
  
  def master_count
    0
  end
end
