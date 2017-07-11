class CreateDeals < ActiveRecord::Migration[4.2]
  def change
    create_table :deals do |t|
      t.integer :task_id
      t.integer :reply_id
    end
  end
end
