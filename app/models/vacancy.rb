# == Schema Information
#
# Table name: vacancies
#
#  id                :integer          not null, primary key
#  title             :string
#  small_description :text
#  description       :text
#  position          :integer
#  archive           :boolean          default(FALSE)
#

class Vacancy < ApplicationRecord
  acts_as_list

  validates :title, :small_description, :description, presence: true

  scope :visible, -> { where{ archive == false } }
end
