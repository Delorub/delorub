class Users::RegistrationsController < Devise::RegistrationsController
  def new
    run User::Registration::Present
  end

  def create
    run User::Registration, sign_up_params do |result|
      return sign_in_and_redirect result['user']
    end

    render 'new'
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
      params.require(:user).permit(:name, :email, :accept_terms, sms_confirmation_attributes: [:phone])
    end
end
