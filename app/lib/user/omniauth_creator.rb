class User::OmniauthCreator
  attr_reader :omniauth

  def initialize omniauth
    @omniauth = omniauth
  end

  def perform
    @user = User.new
    @user.first_name = omniauth.data.info.first_name
    @user.last_name = omniauth.data.info.last_name
    @user.email = omniauth.data.info.email
    @user.password = Devise.friendly_token[0,20]
    @user.omniauth_relations << omniauth
    @user
  end
end
