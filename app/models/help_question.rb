# == Schema Information
#
# Table name: help_questions
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  email    :string(255)
#  content  :text(65535)
#  reply    :text(65535)
#  answered :boolean          default(FALSE)
#

class HelpQuestion < ActiveRecord::Base
  validates :name, :email, :content, presence: true
  validates :content, length: { minimum: 8 }
end
