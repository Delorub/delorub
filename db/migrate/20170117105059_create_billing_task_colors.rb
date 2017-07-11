class CreateBillingTaskColors < ActiveRecord::Migration[4.2]
  def change
    create_table :billing_task_colors do |t|
      t.integer :user_id
      t.integer :task_id

      t.float :cost

      t.timestamps null: false
    end
  end
end
