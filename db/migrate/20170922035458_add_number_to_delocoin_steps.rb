class AddNumberToDelocoinSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :delocoin_steps, :number, :integer
  end
end
