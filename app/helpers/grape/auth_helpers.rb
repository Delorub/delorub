module Grape::AuthHelpers
  extend Grape::API::Helpers

  def current_user
    @current_user = set_user_by_token
  end

  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end

  def set_user_by_token
    uid = request.headers['Uid']
    client = request.headers['Client']

    user = User.find_by(uid: uid)
    if user.tokens.to_h.keys.include? client
      user
    else
      false
    end
  end
end
