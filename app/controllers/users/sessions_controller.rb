class Users::SessionsController < Devise::SessionsController
  def new
    run User::Authentification::Present
  end

  def create
    run User::Authentification, params.require(:user).permit! do |result|
      return sign_in_and_redirect result['user']
    end

    render 'new'
  end

  private

    def after_sign_in_path_for resource
      session[:sign_in_as] = @form.sign_in_as
      super
    end
end
