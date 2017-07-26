class ComingSoonRequestsController < ApplicationController
  def new
    run ComingSoonRequest::Create::Present
  end

  def success; end

  def create
    run ComingSoonRequest::Create,
      coming_soon_session_params,
      visitor_session: visitor_session_service \
      do |result|
        return redirect_to success_coming_soon_requests_path
      end
    render 'new'
  end

  def main_search
    redirect_to new_coming_soon_request_path
  end

  private

  def coming_soon_session_params
    params.require(:coming_soon_request).permit(:email).to_h
  end
end
