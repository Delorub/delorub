class AddSmsVerificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_confirmed, :boolean
  end
end
