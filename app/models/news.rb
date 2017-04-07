# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  photo      :string(255)
#

class News < ActiveRecord::Base
  include Searchable::News

  mount_uploader :photo, NewsPhotoUploader

  validates :title, :content, presence: true
end
