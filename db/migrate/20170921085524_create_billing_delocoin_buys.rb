class CreateBillingDelocoinBuys < ActiveRecord::Migration[5.1]
  def change
    create_table :billing_delocoin_buys do |t|
      t.integer :pack_id
      t.string :pay_type
      t.timestamps null: false
    end
  end
end
