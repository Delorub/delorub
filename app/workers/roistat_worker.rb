class RoistatWorker
  include Sidekiq::Worker

  def perform method, user_id, visitor_id, payload
    user = User.find_by(id: user_id)
    return if user.blank?

    Roistat.new(user, visitor_id).push(method, payload)
  end
end
