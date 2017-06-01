class ApplicationController < ActionController::Base
  include Pundit
  include RenderPageNotFound

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :rescue_not_found

  protect_from_forgery

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

  def after_authorization
    session[:after_authorization]
  end

  def after_authorization= value
    session[:after_authorization] = value
  end
end
