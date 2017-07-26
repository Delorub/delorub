class CreateVisitorSessionActions < ActiveRecord::Migration[5.1]
  def change
    create_table :visitor_session_actions do |t|
      t.belongs_to :visitor_session
      t.string :action_type
      t.string :identity
      t.string :keyword
      t.string :url
      t.text :data
      t.timestamps
    end
  end
end
