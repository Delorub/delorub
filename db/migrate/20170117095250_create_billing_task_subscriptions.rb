class CreateBillingTaskSubscriptions < ActiveRecord::Migration[4.2]
  def change
    create_table :billing_task_subscriptions do |t|
      t.integer :user_id

      t.float :cost
      t.datetime :active_from
      t.datetime :active_to

      t.timestamps null: false
    end
  end
end
