# == Schema Information
#
# Table name: help_categories
#
#  id       :integer          not null, primary key
#  title    :string(255)
#  position :integer
#

class HelpCategory < ActiveRecord::Base
  acts_as_list

  has_many :help_answers, -> { order(position: :asc) }

  validates :title, presence: true
end
