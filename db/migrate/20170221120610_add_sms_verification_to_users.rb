class AddSmsVerificationToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :phone_confirmed, :boolean
  end
end
