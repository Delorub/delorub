class CreateBillingYandexKassaDeposit < ActiveRecord::Migration[5.1]
  def change
    create_table :billing_yandex_kassa_deposits do |t|
      t.decimal :amount
      t.string :pay_type
      t.timestamps null: false
    end
  end
end
