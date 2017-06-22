class AddDateFieldsToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :date_actual_date, :datetime
    add_column :tasks, :date_actual_time, :integer
    add_column :tasks, :date_interval_from, :datetime
    add_column :tasks, :date_interval_to, :datetime
    remove_column :tasks, :date_from
    remove_column :tasks, :date_to
    remove_column :tasks, :date_actual
  end
end
