module Grape::PunditHelpers
  extend Grape::API::Helpers

  def authorize object, action
    policy = determine_policy object
    granted = policy.new(current_user, object).send(action)
    error!('403 Forbidden', 403) unless granted
  end

  private

  def determine_policy object
    if object.is_a? Class
      (object.to_s + 'Policy').constantize
    else
      (ApplicationPolicy.new(current_user, object).scope.to_s + 'Policy').constantize
    end
  end
end
