class ApplicationController < ActionController::Base
  include RenderPageNotFound

  protect_from_forgery

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

  def active_admin_access_denied exception
    raise exception if Rails.env.development?
    render_page_not_found
  end
end
