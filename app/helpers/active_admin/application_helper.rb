module ActiveAdmin::ApplicationHelper
  def nested_set_options_for_category category
    nested_set_options(Category, category) { |i| "#{'-' * i.level} #{i.title}" }
  end

  def billing_log_state_class state
    case state
      when 'new' then 'gray'
      when 'finished' then 'green'
      when 'failed' then 'red'
    end
  end
end
