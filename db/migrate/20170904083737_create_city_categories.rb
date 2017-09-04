class CreateCityCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :city_categories do |t|
      t.references :city, index: true
      t.references :category, index: true
      t.column :settings, :text
      t.column :settings_type, :string
      t.timestamps
    end
  end
end
