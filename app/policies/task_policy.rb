class TaskPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    return false if user.blank?
    record.user.id == user.id
  end

  def reply?
    return true if user.blank?
    return false if record.replies.by_user(user).exists?
    record.user_id != user.id
  end

  def view_replies?
    return false if user.blank?
    record.user.id == user.id
  end
end
