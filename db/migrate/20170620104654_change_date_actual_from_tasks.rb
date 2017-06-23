class ChangeDateActualFromTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :date_actual_date, :date_actual
    remove_column :tasks, :date_actual_time
  end
end
