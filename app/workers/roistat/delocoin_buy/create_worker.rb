class Roistat::DelocoinBuy::CreateWorker
  include Sidekiq::Worker

  def perform id, roistat_visit
    delocoin_buy = Billing::Delocoin::Buy.find(id)
    RoistatService.new(model: delocoin_buy, roistat_visit: roistat_visit).perform_create_delocoin_buy
  end
end
