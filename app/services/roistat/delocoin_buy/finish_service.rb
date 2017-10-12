class Roistat::DelocoinBuy::FinishService < Roistat::BaseService
  def perform
    send_to_url(params.merge(
      'title' => 'Купил пакет',
      'fields' => {
        'status_id' => Figaro.env.roistat_finish_delocoin_buy_status_id,
        Figaro.env.roistat_delocoin_buy_field_cost_id => model.cost,
        'price' => model.cost
      }
    ).to_query)
  end
end
