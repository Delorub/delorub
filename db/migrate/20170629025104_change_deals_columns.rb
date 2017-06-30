class ChangeDealsColumns < ActiveRecord::Migration
  def change
    add_column :deals, :profile_id, :integer
    remove_column :deals, :reply_id, :integer
  end
end
