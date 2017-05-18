# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  slug       :string
#  content    :text
#  draft      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
  include Searchable::Page

  validates :title, :content, :slug, presence: true
  validates :slug, uniqueness: true
end
