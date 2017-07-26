class CreateVisitorSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :visitor_sessions do |t|
      t.string :ip
      t.string :city
      t.timestamps
    end
  end
end
