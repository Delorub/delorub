# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  photo      :string
#

class News < ApplicationRecord
  include Searchable::News

  mount_uploader :photo, NewsPhotoUploader

  validates :title, :content, presence: true
end
