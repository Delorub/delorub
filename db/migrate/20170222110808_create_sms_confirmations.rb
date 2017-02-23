class CreateSmsConfirmations < ActiveRecord::Migration
  def change
    create_table :sms_confirmations do |t|
      t.string :token
      t.string :phone
      t.string :code

      t.boolean :accepted, default: false
      t.integer :attempts, default: 0

      t.datetime :last_sent_at

      t.timestamps null: false
    end
  end
end
