class AfterProfileCreationCreator
  include Rails.application.routes.url_helpers

  attr_reader :type, :data, :path, :profile

  def initialize type, data, profile
    @type = type.to_sym
    @data = data
    @profile = profile
    @path = nil
  end

  def perform
    case type
    when :reply
      create_reply
    end
  end

  def should_clear_session?
    @should_clear_session
  end

  private

    def create_reply
      @path = task_path(data['task_id'])
      form = ReplyForm.new Reply.new(user: profile.user)
      return unless form.validate data
      creator = Reply::FormCreator.new(form)
      creator.perform
      return unless creator.model.persisted?
    end
end
