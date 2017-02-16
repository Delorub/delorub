module ActiveAdmin::ApplicationHelper
  def nested_set_options_for_category category
    nested_set_options(Category, category) { |i| "#{'-' * i.level} #{i.title}" }
  end
end
