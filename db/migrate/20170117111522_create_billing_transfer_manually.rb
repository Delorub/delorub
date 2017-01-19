class CreateBillingTransferManually < ActiveRecord::Migration
  def change
    create_table :billing_transfer_manually do |t|
      t.integer :user_id
      t.integer :admin_id

      t.float :amount

      t.timestamps null: false
    end
  end
end
