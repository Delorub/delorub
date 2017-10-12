class Roistat::Users::RegistrationWorker
  include Sidekiq::Worker

  def perform id, roistat_visit
    user = User.find(id)
    Roistat::User::RegistrationService.new(user: user, roistat_visit: roistat_visit).perform
  end
end
