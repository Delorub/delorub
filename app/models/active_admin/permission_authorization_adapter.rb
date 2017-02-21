module ActiveAdmin
  class PermissionAuthorizationAdapter < AuthorizationAdapter
    def authorized? action, subject = nil
      policy = retreive_policy(subject)
      action = format_action(action, subject)

      policy.class.method_defined?(action) && policy.send(action)
    end

    def scope_collection collection, action = Auth::READ
      scope_collection_finder(collection).new(user, collection).resolve
    end

    def retreive_policy subject
      policy = retrieve_policy_finder(subject).policy
      raise Pundit::NotDefinedError, "unable to find policy for `#{subject.inspect}`" unless policy
      case subject
        when nil then policy.new user, resource
        when Class then policy.new user, subject.new
        else policy.new user, subject
      end
    end

    private

      def format_action action, subject
        case action
          when Auth::CREATE then :create?
          when Auth::UPDATE then :update?
          when Auth::READ then subject.is_a?(Class) ? :index? : :show?
          when Auth::DESTROY then subject.is_a?(Class) ? :destroy_all? : :destroy?
          else "#{action}?"
        end
      end

      def scope_collection_finder collection
        Pundit::PolicyFinder.new([namespace, collection]).scope
      end

      def retrieve_policy_finder subject
        case subject
          when nil then Pundit::PolicyFinder.new [namespace, resource]
          when Class then Pundit::PolicyFinder.new [namespace, subject.new]
          else Pundit::PolicyFinder.new [namespace, subject]
        end
      end

      def namespace
        resource.namespace.name
      end
  end
end
