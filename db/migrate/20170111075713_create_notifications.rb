class CreateNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :message
      t.string :state
      t.text :params

      t.string :notifiable_type
      t.integer :notifiable_id

      t.datetime :read_at

      t.timestamps null: false
    end
  end
end
