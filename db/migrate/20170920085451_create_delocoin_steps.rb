class CreateDelocoinSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :delocoin_steps do |t|
      t.date :date_from
      t.float :rate
      t.boolean :is_current
    end
  end
end
