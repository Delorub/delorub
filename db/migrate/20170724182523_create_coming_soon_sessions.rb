class CreateComingSoonSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :coming_soon_sessions do |t|
      t.string :source
      t.string :source_data
      t.string :action_type
      t.string :form_keyword
      t.string :city
      t.string :referer
      t.string :email
      t.string :ip
      t.timestamp :visited_at
      t.timestamps
    end
  end
end
