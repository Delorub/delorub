class CreatePlaceCategoriesSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :place_categories_settings do |t|
      t.references :place, index: true
      t.references :category, index: true
      t.column :settings, :text
      t.column :settings_type, :string
      t.timestamps
    end
  end
end
