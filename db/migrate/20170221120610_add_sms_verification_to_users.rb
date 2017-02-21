class AddSmsVerificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_confirmation_code, :string
    add_column :users, :phone_confirmation_sended_at, :datetime
    add_column :users, :phone_confirmed, :boolean
  end
end
