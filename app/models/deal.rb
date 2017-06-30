# == Schema Information
#
# Table name: deals
#
#  id         :integer          not null, primary key
#  task_id    :integer
#  profile_id :integer
#

class Deal < ApplicationRecord
  belongs_to :task
  belongs_to :profile

  has_many :comments, as: :commentable, dependent: :destroy
end
