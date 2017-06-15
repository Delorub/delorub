class ApplicationController < ActionController::Base
  include Pundit
  include RenderPageNotFound
  include Authorization

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :rescue_not_found

  before_filter :show_global_container

  protect_from_forgery

  private

    def rescue_not_found exception
      raise exception if Rails.env.development?
      render_page_not_found
    end

    def not_found
      raise ActionController::RoutingError, 'Not Found'
    end

    def active_admin_access_denied exception
      raise exception if Rails.env.development?
      render_page_not_found
    end

    def show_global_container
      @global_container = true
    end
end
