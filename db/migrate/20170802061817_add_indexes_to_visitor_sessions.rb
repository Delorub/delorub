class AddIndexesToVisitorSessions < ActiveRecord::Migration[5.1]
  def change
    add_index :visitor_sessions, :city

    add_index :visitor_session_actions, :action_type
    add_index :visitor_session_actions, [:identity, :action_type]
    add_index :visitor_session_actions, [:keyword, :identity, :action_type], name: 'index_vsa_on_keyword_and_identity_and_action_type'
  end
end
