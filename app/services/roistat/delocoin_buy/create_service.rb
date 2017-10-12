class Roistat::DelocoinBuy::CreateService < Roistat::BaseService
  def perform
    send_to_url(params.merge(
      'title' => 'Выбрал пакет и оплату',
      'fields' => {
        'status_id' => Figaro.env.roistat_create_delocoin_buy_status_id,
        Figaro.env.roistat_delocoin_buy_field_cost_id => model.cost
      }
    ).to_query)
  end
end
