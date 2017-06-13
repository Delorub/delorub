class CreateCategoriesProfiles < ActiveRecord::Migration
  def change
    create_table :categories_profiles, id: false do |t|
      t.belongs_to :profile, index: true
      t.belongs_to :category, index: true

      t.timestamps null: false
    end
  end
end
