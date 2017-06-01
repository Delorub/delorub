# == Schema Information
#
# Table name: billing_transfer_manually
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  admin_id   :integer
#  amount     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Billing::TransferManually < ApplicationRecord
  self.table_name = 'billing_transfer_manually'

  include Billing::Base
  include Billing::Transferable

  belongs_to :admin, class_name: 'User'

  validates :admin, presence: true

  def name
    'Ручное пополнение'
  end
end
