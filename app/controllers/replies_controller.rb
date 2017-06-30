class RepliesController < ApplicationController
  include Pundit
  inherit_resources
  belongs_to :task

  def create
    authorize Reply.new(user: current_user, task: parent), :create?
    @form = ReplyForm.new Reply.new(user: current_user, task: parent)
    if @form.validate reply_params
      unless user_signed_in?
        store_form_to_session
        return redirect_to new_user_session_path, notice: 'Отлично! Для завершения нужно войти либо зарегистрироваться'
      end
      unless current_user.master?
        store_form_to_session
        return redirect_to new_profile_path, notice: 'Нужно заполнить анкету мастера, чтобы откликаться на задания'
      end
      creator = Reply::FormCreator.new(@form)
      creator.perform
      return redirect_to task_path(creator.model.task), notice: 'Отклик добавлен!' if creator.model.persisted?
      flash.alert = creator.last_error
    end
    redirect_to task_path(parent)
  end

  def accept
    authorize resource, :accept?
    Deal::Creator.new(resource).perform
    redirect_to task_path(resource.task), notice: 'Поздравляем! Исполнитель выбран'
  end

  def decline
    authorize resource, :decline?
    resource.decline!
    redirect_to task_path(resource.task), notice: 'Мастеру отказано'
  end

  def cancel_decline
    authorize resource, :cancel_decline?
    resource.cancel_decline!
    redirect_to task_path(resource.task), notice: 'Отказ отменен'
  end

  def show
    authorize resource, :show?
  end

  private

    def store_form_to_session
      @form.save do |data|
        create_after_authorization :reply, data unless user_signed_in?
        create_after_profile_creation :reply, data
      end
    end

    def create_after_profile_creation type, data
      session[:after_profile_creation] = { type: type, data: data }
    end

    def reply_params
      params.require(:reply).permit(:content)
    end
end
