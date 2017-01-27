class Billing::TaskAutorefresh < Billing
  self.table_name = 'billing_task_autorefreshes'
  
  include Billing::Costable

  belongs_to :task
end
