class TaskDecorator < Draper::Decorator
  decorates Task
  delegate_all

  def formatted_date_actual_date
    return unless object.date_actual_date
    object.date_actual_date.strftime '%d.%m.%Y'
  end

  def formatted_date_interval_from
    return unless object.date_interval_from
    object.date_interval_from.strftime '%d.%m.%Y'
  end

  def formatted_date_interval_to
    return unless object.date_interval_to
    object.date_interval_to.strftime '%d.%m.%Y'
  end

  def formatted_date_actual_time
    return unless object.date_actual_time
    format '%02d:%02d', date_actual_time_hour, date_actual_time_minute
  end

  def date_actual_time_hour
    return unless object.date_actual_time
    object.date_actual_time / 60
  end

  def date_actual_time_minute
    return unless object.date_actual_time
    object.date_actual_time % 60
  end
end
