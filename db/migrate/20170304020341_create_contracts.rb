class CreateContracts < ActiveRecord::Migration[4.2]
  def change
    create_table :contracts do |t|
      t.integer :template_id

      t.text :data

      t.timestamps null: false
    end
  end
end
