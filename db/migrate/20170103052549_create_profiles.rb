class CreateProfiles < ActiveRecord::Migration[4.2]
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false

      t.string :work_type
      t.string :pay_type

      t.boolean :have_car
      t.boolean :have_truck

      t.text :about

      t.integer :place_id, null: true
      t.float :place_lat, null: true
      t.float :place_long, null: true
      t.string :place_address

      t.timestamps null: false
    end
  end
end
