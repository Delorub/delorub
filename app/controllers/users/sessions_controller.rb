class Users::SessionsController < Devise::SessionsController
  def new
    run User::Authentification::Present
  end

  def create
    run User::Authentification, params.require(:user).permit! do |result|
      sign_in result['user']
      return redirect_to root_path
    end

    render 'new'
  end

  def sign_in_as
    not_found unless params[:type].in? %w[master user]
    session[:signed_in_as] = params[:type]
    redirect_back fallback_location: my_index_index_path
  end

  private

    def after_sign_in_path_for resource
      session[:signed_in_as] = @form.signed_in_as
      super
    end
end
