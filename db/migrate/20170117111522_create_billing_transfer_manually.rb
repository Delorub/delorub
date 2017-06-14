class CreateBillingTransferManually < ActiveRecord::Migration
  def change
    create_table :billing_transfer_manually do |t|
      t.integer :user_id
      t.integer :admin_id

      t.decimal :amount, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
