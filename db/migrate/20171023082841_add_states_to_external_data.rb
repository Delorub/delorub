class AddStatesToExternalData < ActiveRecord::Migration[5.1]
  def change
    add_column :external_data, :parser_filter_state, :string
  end
end
