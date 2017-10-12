class Roistat::DelocoinBuy::FinishWorker
  include Sidekiq::Worker

  def perform id, roistat_visit
    model = Billing::Delocoin::Buy.find(id)
    Roistat::DelocoinBuy::FinishService.new(user: model.user, roistat_visit: roistat_visit, model: model).perform
  end
end
