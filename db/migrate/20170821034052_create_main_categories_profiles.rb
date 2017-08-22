class CreateMainCategoriesProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :main_categories_profiles do |t|
      t.integer :main_category_id
      t.integer :profile_id
      t.text :description
    end

    add_index :main_categories_profiles, [:main_category_id, :profile_id],
      unique: true, name: 'main_categories_profiles_category_and_profile'
  end
end
