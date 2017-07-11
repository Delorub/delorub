class CreateUserPermissions < ActiveRecord::Migration[4.2]
  def change
    create_table :user_permissions do |t|
      t.text :data

      t.timestamps null: false
    end
  end
end
