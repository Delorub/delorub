module Grape::PunditHelpers
  extend Grape::API::Helpers

  def authorize record, action
    policy = (ApplicationPolicy.new(current_user, record).scope.to_s + 'Policy').constantize
    granted = policy.new(current_user, record).send(action)
    error!('403 Forbidden', 403) unless granted
  end
end
