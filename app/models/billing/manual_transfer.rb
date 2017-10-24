# == Schema Information
#
# Table name: billing_manual_transfer
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  admin_id   :integer
#  amount     :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Billing::ManualTransfer < ApplicationRecord
  self.table_name = 'billing_manual_transfer'

  include Billing::Base

  belongs_to :admin, class_name: 'User'
  belongs_to :user

  validates :admin, presence: true

  def name
    'Ручное пополнение'
  end
end
