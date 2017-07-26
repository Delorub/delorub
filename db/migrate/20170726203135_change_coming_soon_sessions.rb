class ChangeComingSoonSessions < ActiveRecord::Migration[5.1]
  def change
    remove_column :coming_soon_sessions, :city, :string
    remove_column :coming_soon_sessions, :source, :string
    remove_column :coming_soon_sessions, :referer, :string
    remove_column :coming_soon_sessions, :source_data, :string
    remove_column :coming_soon_sessions, :action_type, :string
    remove_column :coming_soon_sessions, :form_keyword, :string
    remove_column :coming_soon_sessions, :ip, :string
    remove_column :coming_soon_sessions, :visited_at, :datetime
    remove_column :coming_soon_sessions, :utm_data, :text
    add_column :coming_soon_sessions, :visitor_session_id, :integer
    rename_table :coming_soon_sessions, :coming_soon_requests
  end
end
