module Grape::AuthHelpers
  extend Grape::API::Helpers

  def current_user
    @current_user = User.find_by(access_token: cookies[:access_token])
  end

  def authenticate_user!
    error!('401 Unauthorized', 401) unless current_user
  end
end
