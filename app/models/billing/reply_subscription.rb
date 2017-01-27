class Billing::ReplySubscription < ActiveRecord::Base
  self.table_name = 'billing_reply_subscriptions'
  
  include Billing::Base
  include Billing::Costable
  include Billing::Subscriptionable
  
  has_many :replies
  
  def name
    "Абонемент на ответы"
  end
end
