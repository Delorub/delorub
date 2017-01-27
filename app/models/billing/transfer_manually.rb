class Billing::TransferManually < ActiveRecord::Base
  self.table_name = 'billing_transfer_manually'

  include Billing::Base
  include Billing::Transferable

  belongs_to :admin
end
