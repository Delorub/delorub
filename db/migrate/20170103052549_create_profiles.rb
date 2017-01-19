class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      
      t.string :work_type
      t.string :pay_type

      t.boolean :have_car
      t.boolean :have_truck
      
      t.text :about
      
      t.integer :geo_id, null: true
      t.float :geo_lat, null: true
      t.float :geo_long, null: true
      t.string :geo_address
      
      t.timestamps null: false
    end
  end
end
