class ChangeUsersBalanceColumn < ActiveRecord::Migration
  # TODO delete after production release
  def change
    change_column :users, :balance, :decimal, precision: 10, scale: 2
    change_column :billing_transfer_manually, :amount, :decimal, precision: 10, scale: 2
  end
end
