class Roistat::DelocoinBuy::CreateWorker
  include Sidekiq::Worker

  def perform id, roistat_visit
    model = Billing::Delocoin::Buy.find(id)
    Roistat::DelocoinBuy::CreateService.new(user: model.user, roistat_visit: roistat_visit, model: model).perform
  end
end
