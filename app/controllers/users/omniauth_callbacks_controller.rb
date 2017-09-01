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

  private

    def authorize_omniauth_to_current_user
      @omniauth = User::OmniauthRelation.find_or_initialize_by \
        provider: omniauth_data.provider,
        external_id: omniauth_data.uid

      if @omniauth.user.present?
        return redirect_to my_index_index_path, alert: 'Этот аккаунт уже привязан к другому профилю'
      end

      @omniauth.data = omniauth_data
      @omniauth.user = current_user
      @omniauth.save

      redirect_to my_index_index_path
    end

    def authorize_omniauth_to_new_user
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

    def authorize_omniauth
      return authorize_omniauth_to_current_user if user_signed_in?
      authorize_omniauth_to_new_user
    end

    def omniauth_data
      request.env['omniauth.auth']
    end

    def success_sign_in user
      sign_in user
      redirect_to my_welcome_index_path
    end
end
