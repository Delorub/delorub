class AddExternalDataSettingsToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :external_data_settings, :text
  end
end
