class AddStateToReplies < ActiveRecord::Migration[4.2]
  def change
    add_column :replies, :aasm_state, :string
    add_index :replies, :aasm_state
  end
end
