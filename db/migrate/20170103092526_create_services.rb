class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :profile_id
      
      t.string :title
      t.integer :price
      t.string :price_type
      
      t.timestamps null: false
    end
  end
end
