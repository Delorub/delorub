class AddImageToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :photo, :string
  end
end
