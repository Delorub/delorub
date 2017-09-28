class ChangeUserBalanceFields < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :delocoin_balance, :decimal, default: 0.0, precision: 10, scale: 2
  end
end
