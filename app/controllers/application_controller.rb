class ApplicationController < ActionController::Base
  include RenderPageNotFound

  protect_from_forgery

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def active_admin_access_denied exception
    if Rails.env.development?
      raise exception
    else
      render_page_not_found
    end
  end
end
