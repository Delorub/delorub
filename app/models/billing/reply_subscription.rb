# == Schema Information
#
# Table name: billing_reply_subscriptions
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  cost        :float(24)
#  active_from :datetime
#  active_to   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

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
