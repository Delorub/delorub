class VisitorSessionDecorator < Draper::Decorator
  decorates :visitor_session
  delegate_all

  def first_source
    actions.find_by action_type: %w[yandex_direct utm_source]
  end

  def first_link
    actions.find_by action_type: %w[internal_link]
  end

  def first_form
    actions.find_by action_type: %w[post_form]
  end
end
