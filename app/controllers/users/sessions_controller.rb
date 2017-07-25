class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def new
    run User::Authentification::Present
  end

  def create
    run User::Authentification, permitted_params do |result|
      return sign_in result['user']
    end

    render 'new'
  end

  # POST /resource/sign_in
  # def create
  #  super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private

    def permitted_params
      params.require(:user).permit(:email, :password).to_h
    end
end
