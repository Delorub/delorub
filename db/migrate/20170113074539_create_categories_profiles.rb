class CreateCategoriesProfiles < ActiveRecord::Migration[4.2]
  def change
    create_table :categories_profiles, id: false do |t|
      t.belongs_to :profile, index: true
      t.belongs_to :category, index: true

      t.timestamps null: false
    end
  end
end
