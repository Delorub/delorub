class CreateBillingTaskPacks < ActiveRecord::Migration[4.2]
  def change
    create_table :billing_task_packs do |t|
      t.integer :user_id

      t.float :cost

      t.integer :amount
      t.integer :spent, null: false, default: 0

      t.boolean :available, default: true

      t.timestamps null: false
    end
  end
end
