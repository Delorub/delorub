class CreateExternalDataVkAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :external_data_vk_accounts do |t|
      t.string :login
      t.string :password

      t.string :state
      t.string :access_token
      t.datetime :access_token_generated_at
      t.integer :access_token_attempts_count, default: 0

      t.text :info

      t.timestamps null: false
    end
  end
end
