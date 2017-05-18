# == Schema Information
#
# Table name: billing_task_subscriptions
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  cost        :float
#  active_from :datetime
#  active_to   :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Billing::TaskSubscription < ActiveRecord::Base
  self.table_name = 'billing_task_subscriptions'

  include Billing::Base
  include Billing::Costable
  include Billing::Subscriptionable

  has_many :tasks

  def name
    'Абонемент на задания'
  end
end
