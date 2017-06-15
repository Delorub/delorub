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

      return success_sign_in @omniauth.user if @omniauth.user

      @user = User::OmniauthCreator.new(@omniauth).perform

      if @user.valid?
        @user.save
        return success_sign_in @user
      end

      flash.now.notice = 'Поздравляем! Осталось указать немного информации о себе'
      render 'devise/registrations/new'
    end

    def omniauth_data
      request.env['omniauth.auth']
    end

    def success_sign_in user
      sign_in_and_redirect user
    end

    def resource
      @user
    end

    def resource_name
      :user
    end

    def devise_mapping
      @devise_mapping ||= request.env['devise.mapping']
    end
end
