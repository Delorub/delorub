class AddStateToUserBillingLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :user_billing_logs, :state, :string
  end
end
