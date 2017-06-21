class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :task_id
      t.integer :reply_id
    end
  end
end
