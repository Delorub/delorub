class RoistatWorker
  include Sidekiq::Worker

  def perform method, user_id, visitor_id, payload
    user = User.find(user_id)
    Roistat.new(user, visitor_id).push(method, payload)
  end
end
