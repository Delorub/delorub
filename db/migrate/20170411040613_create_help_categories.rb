class CreateHelpCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :help_categories do |t|
      t.string :title
      t.integer :position
    end
  end
end
