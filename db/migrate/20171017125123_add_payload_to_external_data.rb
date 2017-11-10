class AddPayloadToExternalData < ActiveRecord::Migration[5.1]
  def change
    add_column :external_data, :payload, :text
  end
end
