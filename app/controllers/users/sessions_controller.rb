class Users::SessionsController < Devise::SessionsController
  protect_from_forgery prepend: true

  def new
    run User::Authentification::Present
  end

  def create
    run User::Authentification, params.require(:user).permit! do |result|
      sign_in result['user']

      if @form.sign_in_as == 'master' && result['user'].profile.blank?
        session[:signed_in_as] = 'user'
        return redirect_to new_profile_path
      end
      session[:signed_in_as] = @form.sign_in_as

      return redirect_to root_path
    end

    render 'new'
  end

  def sign_in_as
    not_found unless user_signed_in?
    not_found unless params[:type].in? %w[master user]
    if params[:type] == 'master' && current_user.profile.blank?
      return redirect_to new_profile_path
    end
    session[:signed_in_as] = params[:type]
    redirect_back fallback_location: my_index_index_path
  end
end
