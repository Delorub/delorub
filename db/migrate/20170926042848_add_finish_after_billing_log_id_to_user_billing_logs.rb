class AddFinishAfterBillingLogIdToUserBillingLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :user_billing_logs, :finish_after_billing_log_id, :integer
  end
end
