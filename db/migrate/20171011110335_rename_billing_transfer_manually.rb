class RenameBillingTransferManually < ActiveRecord::Migration[5.1]
  def change
    rename_table :billing_transfer_manually, :billing_manual_transfer
  end
end
