class ChangeDateActualFromTasks < ActiveRecord::Migration[4.2]
  def change
    rename_column :tasks, :date_actual_date, :date_actual
    remove_column :tasks, :date_actual_time
  end
end
