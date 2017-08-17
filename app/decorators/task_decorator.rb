class TaskDecorator < Draper::Decorator
  decorates Task
  delegate_all

  def main_category_id
    return if object.category.blank?
    return if object.category.parent.blank?
    category.parent.id
  end

  def date_actual_date
    return if object.date_actual.blank?
    I18n.l object.date_actual, format: :date
  end

  def date_actual_time
    return if object.date_actual.blank?
    I18n.l object.date_actual, format: :timeofday
  end

  def date_interval_from_date
    return if object.date_interval_from.blank?
    I18n.l object.date_interval_from, format: :date
  end

  def date_interval_to_date
    return if object.date_interval_to.blank?
    I18n.l object.date_interval_to, format: :date
  end
end
