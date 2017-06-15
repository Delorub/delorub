class CreateTaskFiles < ActiveRecord::Migration
  def change
    create_table :task_files do |t|
      t.string :file
      t.integer :task_id

      t.timestamps null: false
    end

    add_index :task_files, :task_id
  end
end
