class CreateSubcategoriesTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :subcategories_tasks do |t|
      t.integer :subcategory_id
      t.integer :task_id
    end

    add_index :subcategories_tasks, [:subcategory_id, :task_id], unique: true
  end
end
