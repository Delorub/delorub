module VisitorSessionHandler
  extend ActiveSupport::Concern

  included do
    before_action :handle_visitor_session
  end

  def visitor_session_service
    @visitor_session_service
  end

  protected

    def handle_visitor_session
      return if self.class.parent.in? [Admin, Editor]
      return if user_signed_in?
      @visitor_session_service = VisitorSessionService.new(request, session, cookies)
      @visitor_session_service.perform
    end
end
