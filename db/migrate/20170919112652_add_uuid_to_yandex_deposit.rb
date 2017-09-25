class AddUuidToYandexDeposit < ActiveRecord::Migration[5.1]
  def change
    add_column :billing_yandex_kassa_deposits, :uuid, :string, index: true, unique: true
    add_column :billing_yandex_kassa_deposits, :params, :text
  end
end
