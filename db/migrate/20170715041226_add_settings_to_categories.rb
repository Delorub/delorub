class AddSettingsToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :settings, :text
  end
end
