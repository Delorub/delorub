class AddCostDataToBillingDelocoinBuys < ActiveRecord::Migration[5.1]
  def change
    add_column :billing_delocoin_buys, :cost, :float, precision: 10, scale: 2
    add_column :billing_delocoin_buys, :delocoin_amount, :integer
    add_column :billing_delocoin_buys, :step_id, :integer
  end
end
