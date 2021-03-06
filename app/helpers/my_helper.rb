module MyHelper
  def my_sidebar_item_class_for name
    'active' if controller_name.to_sym == name
  end

  def active_class_if controller, action = nil
    return if controller_name.to_sym != controller
    if action.present?
      return if action.is_a?(Symbol) && action_name.to_sym != action
      return if action.is_a?(Array) && !action_name.to_sym.in?(action)
    end
    'active'
  end
end
