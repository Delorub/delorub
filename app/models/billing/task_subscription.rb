class Billing::TaskSubscription < ActiveRecord::Base
  self.table_name = 'billing_task_subscriptions'
  
  include Billing::Base
  include Billing::Costable
  include Billing::Subscriptionable
  
  has_many :tasks
  
  def name
    "Абонемент на задания"
  end
end
