class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :fias_aoguid
      
      t.string :name
      t.string :full_name

      t.integer :level
      t.integer :place_type
      t.integer :place_type_name_id
      
      t.integer :parent_place_id
      t.integer :region_place_id
      
      t.boolean :is_region_center
      t.boolean :is_center
      t.boolean :custom
    end
  end
end
