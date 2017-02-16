# == Schema Information
#
# Table name: billing_task_blogs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  task_id    :integer
#  cost       :float(24)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Billing::TaskBlog < Billing
  self.table_name = 'billing_task_blogs'

  include Billing::Costable

  belongs_to :task
end
