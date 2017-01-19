class CreateBillingTaskAutorefreshes < ActiveRecord::Migration
  def change
    create_table :billing_task_autorefreshes do |t|
      t.integer :user_id
      t.integer :task_id

      t.float :cost

      t.timestamps null: false
    end
  end
end
