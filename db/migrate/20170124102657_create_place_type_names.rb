class CreatePlaceTypeNames < ActiveRecord::Migration
  def change
    create_table :place_type_names do |t|
      t.integer :level
      t.integer :code
      t.string :name
      t.string :full_name
      t.string :alt_name
      t.boolean :after_place_name

      t.timestamps null: false
    end
  end
end
