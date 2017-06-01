# == Schema Information
#
# Table name: help_answers
#
#  id               :integer          not null, primary key
#  help_category_id :integer
#  title            :string
#  content          :text
#  synonyms         :text
#  position         :integer
#

class HelpAnswer < ApplicationRecord
  include Searchable::HelpAnswer

  belongs_to :help_category

  acts_as_list scope: :help_category

  validates :title, :content, :help_category, presence: true
end
