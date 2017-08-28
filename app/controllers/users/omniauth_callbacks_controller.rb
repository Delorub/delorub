class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authorize_omniauth
  end

  def vkontakte
    authorize_omniauth
  end

  def odnoklassniki
    authorize_omniauth
  end

  def failure
    redirect_to new_user_session_path, alert: 'Не удалось войти через социальные сети'
  end

  helper_method :resource, :resource_name, :devise_mapping

  private

    def authorize_omniauth
      @omniauth = User::OmniauthRelation.find_or_initialize_by \
        provider: omniauth_data.provider,
        external_id: omniauth_data.uid
      @omniauth.data = omniauth_data
      @omniauth.save

      return sign_in_and_redirect @omniauth.user if @omniauth.user

      @user = User::OmniauthCreator.new(@omniauth).perform
      return success_sign_in @user if @user

      failure
    end

    def omniauth_data
      request.env['omniauth.auth']
    end

    def success_sign_in user
      sign_in user
      redirect_to my_welcome_index_path
    end
end
