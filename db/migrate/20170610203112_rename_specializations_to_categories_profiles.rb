class RenameSpecializationsToCategoriesProfiles < ActiveRecord::Migration
  # TODO delete after production release
  def change
    rename_table :specializations, :categories_profiles
  end
end
