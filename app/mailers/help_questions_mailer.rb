class HelpQuestionsMailer < ApplicationMailer
  default from: 'support@delorub.ru'

  def reply help_question
    @help_question = help_question
    mail to: @help_question.email, subject: 'Ваш вопрос в службу поддержки Делоруб.ру'
  end
end
