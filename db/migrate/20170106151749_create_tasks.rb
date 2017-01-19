class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      
      t.integer :category_id, null: false
      t.integer :user_id, null: false
      
      t.string :price_type, null: false
      t.string :price_scale, null: true
      t.integer :price_exact, null: true
      t.integer :price_from, null: true
      t.integer :price_to, null: true
      
      t.integer :geo_id, null: true
      t.float :geo_lat, null: true
      t.float :geo_long, null: true
      t.string :geo_address
      
      t.string :date_type, null: false
      t.integer :date_actual, null: true
      t.datetime :date_from, null: true
      t.datetime :date_to, null: true
      
      t.string :contract_type
      t.text :description
      
      t.boolean :notify_email
      t.boolean :visible, default: true
      t.boolean :archive
      
      t.boolean :colored, default: false
      
      t.string :billable_type
      t.integer :billable_id
      
      t.timestamps null: false
    end
  end
end
