class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :phone
      t.string :skype
      t.string :website
      t.date :birthday

      t.integer :profile_id, null: true

      t.integer :free_tasks_published, null: false, default: 0
      t.integer :free_replies_published, null: false, default: 0

      t.float :balance, null: false, default: 0.0

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
