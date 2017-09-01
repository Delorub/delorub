module MyHelper
  def my_sidebar_item_class_for name
    'active' if controller_name.to_sym == name
  end
end
