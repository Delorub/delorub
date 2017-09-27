class AddBuyAvailableToDelocoinSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :delocoin_steps, :buy_available, :boolean
  end
end
