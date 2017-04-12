# == Schema Information
#
# Table name: vacancies
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  small_description :text(65535)
#  description       :text(65535)
#  position          :integer
#  archive           :boolean          default(FALSE)
#

class Vacancy < ActiveRecord::Base
  acts_as_list

  validates :title, :small_description, :description, presence: true

  scope :visible, -> { where{ archive == false } }
end
