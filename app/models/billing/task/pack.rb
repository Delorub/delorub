class Billing::Task::Pack < ActiveRecord::Base
  self.table_name = 'billing_task_packs'
  
  include Billing::Base
  include Billing::Costable
  include Billing::Packable
  
  has_many :tasks
  
  def name
    "Пакет заданий"
  end
end
