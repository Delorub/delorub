class RenameSpecializationsToCategoriesProfiles < ActiveRecord::Migration
  def change
    rename_table :specializations, :categories_profiles
  end
end
