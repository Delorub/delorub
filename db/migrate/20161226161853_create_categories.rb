class CreateCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.integer :parent_id
      t.timestamps null: false
    end
  end
end
