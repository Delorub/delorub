# == Schema Information
#
# Table name: help_answers
#
#  id               :integer          not null, primary key
#  help_category_id :integer
#  title            :string(255)
#  content          :text(65535)
#  synonyms         :text(65535)
#  position         :integer
#

class HelpAnswer < ActiveRecord::Base
  include Searchable::HelpAnswer

  belongs_to :help_category

  acts_as_list scope: :help_category

  validates :title, :content, :help_category, presence: true
end
