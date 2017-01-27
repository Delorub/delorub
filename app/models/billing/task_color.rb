class Billing::TaskColor < Billing
  self.table_name = 'billing_task_colors'
  
  include Billing::Costable

  belongs_to :task
end
