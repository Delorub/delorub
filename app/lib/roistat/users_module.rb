module Roistat::UsersModule
  extend ActiveSupport::Concern

  def user_registration *args
    {
      'title' => 'Регистрация пользователя',
      'fields' => {
        'status_id' => Figaro.env.roistat_registration_user_status_id
      }
    }
  end
end
