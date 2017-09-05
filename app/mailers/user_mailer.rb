class UserMailer < ApplicationMailer
  def welcome user:, password:
    @user = user.decorate
    @password = password
    mail to: @user.email, subject: 'Регистрация на ДелоРубе'
  end
end
