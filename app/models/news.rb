class News < ActiveRecord::Base
  include Searchable::Page
  
  validates :title, :content, presence: true
end
