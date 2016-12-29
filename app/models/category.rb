class Category < ActiveRecord::Base
  belongs_to :parent_category, -> { where parent_id: nil }, class_name: "Category", foreign_key: :parent_id
  has_many :subcategories, class_name: "Category"

  scope :root, -> { where parent_id: nil }

  validates :title, presence: true
  
  def form_count
    0
  end
  
  def master_count
    0
  end
end
