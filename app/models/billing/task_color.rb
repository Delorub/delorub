# == Schema Information
#
# Table name: billing_task_colors
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  task_id    :integer
#  cost       :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Billing::TaskColor < Billing
  self.table_name = 'billing_task_colors'

  include Billing::Costable

  belongs_to :task
end
