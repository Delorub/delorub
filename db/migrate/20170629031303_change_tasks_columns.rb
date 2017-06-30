class ChangeTasksColumns < ActiveRecord::Migration
  class Task < ActiveRecord::Base; end

  def up
    add_column :tasks, :aasm_state, :string
    add_index :tasks, :aasm_state
    remove_column :tasks, :visible, :boolean
    remove_column :tasks, :archive, :boolean
    Task.find_each do |task|
      task.update_attributes!(aasm_state: :active)
    end
  end

  def down
    remove_column :tasks, :aasm_state, :string
    remove_index :tasks, :aasm_state
    add_column :tasks, :visible, :boolean, default: true
    add_column :tasks, :archive, :boolean
  end
end
