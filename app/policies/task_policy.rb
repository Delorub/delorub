class TaskPolicy < ApplicationPolicy
  def create?
    true
  end

  def edit?
    return false if user.blank?
    record.user.id == user.id
  end

  def reply?
    return true if user.blank?
    record.user.id != user.id
  end
end
