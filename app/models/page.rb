class Page < ActiveRecord::Base
  include Searchable::Page
  
  validates :title, :content, :slug, presence: true
  validates :slug, uniqueness: true
end
