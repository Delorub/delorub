class ApplicationController < ActionController::Base
  include Pundit
  include RenderPageNotFound
  include VisitorSessionHandler
  include Authorization

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :rescue_not_found
  rescue_from Pundit::NotAuthorizedError, with: :rescue_not_authorized

  after_action :allow_iframe

  protect_from_forgery

  private

    def rescue_not_found exception
      raise exception if Rails.env.development?
      render_page_not_found
    end

    def not_found
      raise ActionController::RoutingError, 'Not Found'
    end

    def access_denied exception
      raise exception if Rails.env.development?
      render_page_not_found
    end

    def rescue_not_authorized exception
      raise exception if Rails.env.development?
      return render_page_not_found if user_signed_in?
      redirect_to new_user_session_path, alert: 'Войдите в систему для просмотра этой страницы'
    end

    def allow_iframe
      response.headers.except! 'X-Frame-Options'
    end
end
