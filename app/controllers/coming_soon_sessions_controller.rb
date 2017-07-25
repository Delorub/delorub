class ComingSoonSessionsController < ApplicationController
  def new
    run ComingSoonSession::Create::Present
  end

  def create
    run ComingSoonSession::Create,
      coming_soon_session_params,
      request: request,
      session: session[:visitor] \
      do |result|
        return redirect_to new_coming_soon_session_path
      end
    render 'new'
  end

  private

  def coming_soon_session_params
    params.require(:coming_soon_session).permit(:email).to_h
  end
end
