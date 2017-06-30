class Deal::Creator
  attr_reader :reply, :model

  def initialize reply
    @reply = reply
  end

  def perform
    Deal.transaction do
      model = Deal.new profile: reply.user.profile, task: reply.task
      model.save
      reply.accept!
    end
  end
end
