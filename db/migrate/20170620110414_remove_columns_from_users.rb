class RemoveColumnsFromUsers < ActiveRecord::Migration[4.2]
  # TODO remove after production release
  def change
    remove_column :users, :uid
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
    remove_column :users, :tokens
  end
end
