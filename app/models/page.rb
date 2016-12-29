class Page < ActiveRecord::Base
  validates :title, :content, :slug, presence: true
  validates :slug, uniqueness: true
end
