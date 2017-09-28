class CreateDelocoinPacks < ActiveRecord::Migration[5.1]
  def change
    create_table :delocoin_packs do |t|
      t.integer :cost
      t.float :discount
    end
  end
end
