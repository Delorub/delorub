class Roistat::User::RegistrationService < Roistat::BaseService
  def perform
    send_to_url(params.merge(
      'title' => 'Регистрация пользователя',
      'fields' => {
        'status_id' => Figaro.env.roistat_registration_user_status_id
      }
    ).to_query)
  end
end
