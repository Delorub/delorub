class AddIsPublicToDelocoinSteps < ActiveRecord::Migration[5.1]
  def change
    add_column :delocoin_packs, :is_public, :boolean, default: false
  end
end
