class Billing::TaskBlog < Billing
  self.table_name = 'billing_task_blogs'

  include Billing::Costable

  belongs_to :task
end
