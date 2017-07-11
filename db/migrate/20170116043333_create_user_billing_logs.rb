class CreateUserBillingLogs < ActiveRecord::Migration[4.2]
  def change
    create_table :user_billing_logs do |t|
      t.float :sum
      t.integer :user_id

      t.string :billable_type
      t.integer :billable_id

      t.timestamps null: false
    end
  end
end
