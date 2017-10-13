module Roistat::DelocoinBuy
  extend ActiveSupport::Concern

  def delocoin_buy_create *args
    {
      'title' => 'Выбрал пакет и оплату',
      'fields' => {
        'status_id' => Figaro.env.roistat_create_delocoin_buy_status_id,
        Figaro.env.roistat_delocoin_buy_field_cost_id => args[0]
      }
    }
  end

  def delocoin_buy_finish *args
    {
      'title' => 'Купил пакет',
      'fields' => {
        'status_id' => Figaro.env.roistat_finish_delocoin_buy_status_id,
        Figaro.env.roistat_delocoin_buy_field_cost_id => args[0],
        'price' => args[0]
      }
    }
  end
end
