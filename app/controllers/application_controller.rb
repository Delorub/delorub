class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]

  include SimpleCaptcha::ControllerHelpers

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    #return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    #if current_user && !current_user.email_verified?
    #  redirect_to finish_signup_path(current_user)
    #end
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    #rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  private
  
  def render_maintenance
    respond_to do |format|
      format.html { render template: 'errors/maintenance', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
  
  def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/file_not_found', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    @error = exception
    respond_to do |format|
      format.html { render template: 'errors/internal_server_error', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end

end
