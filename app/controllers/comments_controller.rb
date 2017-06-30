class CommentsController < ApplicationController
  include Pundit
  inherit_resources
  belongs_to :reply, :deal, polymorphic: true

  def create
    authorize Comment.new(user: current_user, commentable: parent), :create?
    @form = CommentForm.new Comment.new(user: current_user, commentable: parent)
    if @form.validate comment_params
      creator = Comment::FormCreator.new(@form)
      creator.perform
      if creator.model.persisted?
        return redirect_to create_redirect_path(creator), notice: 'Комментарий добавлен!'
      end
      flash.alert = creator.last_error
    end
    redirect_to task_path(parent)
  end

  private

    def create_redirect_path creator
      if parent.is_a? Reply
        if creator.model.commentable.user == creator.model.user
          task_path(creator.model.commentable.task)
        else
          task_reply_path(creator.model.commentable.task, creator.model.commentable)
        end
      elsif parent.is_a? Deal
        deal_path(creator.model.commentable)
      end
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
end
