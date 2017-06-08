class User::OmniauthCreator
  attr_reader :omniauth

  def initialize omniauth
    @omniauth = omniauth
  end

  def perform
    @user = User.new
    @user.first_name = omniauth.data.info.first_name
    @user.last_name = omniauth.data.info.last_name
    @user.omniauth_relations << omniauth
    @user
  end
end
