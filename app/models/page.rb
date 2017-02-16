# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  slug       :string(255)
#  content    :text(65535)
#  draft      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
  include Searchable::Page
  
  validates :title, :content, :slug, presence: true
  validates :slug, uniqueness: true
end
