class ReplyPolicy < ApplicationPolicy
  def create?
    TaskPolicy.new(user, record.task).reply?
  end

  def update?
    return false if user.blank?
    user.id == record.user_id
  end

  def destroy?
    return false if user.blank?
    user.id == record.user_id
  end

  def accept?
    task_owner? && record.may_accept?
  end

  def show?
    comment?
  end

  def comment?
    task_owner?
  end

  def decline?
    task_owner? && record.may_decline?
  end

  def cancel_decline?
    task_owner? && record.may_cancel_decline?
  end

  private

    def task_owner?
      return false if user.blank?
      record.task.user.id == user.id
    end
end
