class AddUtmDataToComingSoonSessions < ActiveRecord::Migration[5.1]
  def change
    add_column :coming_soon_sessions, :utm_data, :text
  end
end
