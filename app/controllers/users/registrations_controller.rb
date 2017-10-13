class Users::RegistrationsController < Devise::RegistrationsController
  def new
    run User::Operation::Registration::Present
  end

  def create
    run User::Operation::Registration, params.require(:user).permit! do |result|
      sign_in result['model']
      roistat.push_async(:user_registration)

      return redirect_to my_welcome_index_path
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
end
