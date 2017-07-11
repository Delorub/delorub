class AddPermissionToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :user_permissions, :user_id, :integer
  end
end
