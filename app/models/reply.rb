# == Schema Information
#
# Table name: replies
#
#  id            :integer          not null, primary key
#  task_id       :integer
#  user_id       :integer
#  status        :string(255)
#  content       :text(65535)
#  billable_type :string(255)
#  billable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Reply < ActiveRecord::Base
  include Searchable::Reply

  belongs_to :task
  belongs_to :user
  belongs_to :billable, polymorphic: true

  validates :user, :task, presence: true
end
