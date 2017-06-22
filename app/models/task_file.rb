# == Schema Information
#
# Table name: task_files
#
#  id         :integer          not null, primary key
#  file       :string
#  task_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_task_files_on_task_id  (task_id)
#

class TaskFile < ApplicationRecord
  mount_uploader :file, TaskFileUploader
  validates :file, presence: true
end
