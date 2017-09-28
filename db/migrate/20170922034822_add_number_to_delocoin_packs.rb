class AddNumberToDelocoinPacks < ActiveRecord::Migration[5.1]
  def change
    add_column :delocoin_packs, :number, :integer
  end
end
