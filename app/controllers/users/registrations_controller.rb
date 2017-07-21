class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super do
      @form = User::RegistrationForm.new resource
      @form.prepopulate!
    end
  end

  def create
    super do
      add_omniauth_to_resource params[:omniauth_id] if params[:omniauth_id]
    end
  end

  private

    def add_omniauth_to_resource omniauth_id
      @omniauth = User::OmniauthRelation.find omniauth_id
      return if @omniauth.user
      return unless resource.persisted?
      @omniauth.user = resource
      @omniauth.save!
    end

    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation)
    end
end
