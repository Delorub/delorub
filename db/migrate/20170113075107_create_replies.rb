class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :task_id
      t.integer :user_id
      
      t.string :status
      
      t.text :content
      
      t.string :billable_type
      t.integer :billable_id
      
      t.timestamps null: false
    end
  end
end
