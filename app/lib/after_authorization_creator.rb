class AfterAuthorizationCreator
  include Rails.application.routes.url_helpers

  attr_reader :type, :data, :path, :user

  def initialize type, data, user
    @type = type.to_sym
    @should_clear_session = false
    @data = data
    @user = user
    @path = nil
  end

  def perform
    case type
    when :task
      create_task
    end
  end

  def should_clear_session?
    @should_clear_session
  end

  private

    def create_task
      @path = new_task_path
      form = TaskForm.new Task.new(user: user).decorate
      return unless form.validate data
      creator = Task::FormCreator.new(form)
      creator.perform
      return unless creator.model.persisted?
      @should_clear_session = true
      @path = task_path(creator.model)
    end
end
