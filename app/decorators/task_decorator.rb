class TaskDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  decorates Task
  decorates_association :user
  delegate_all

  def main_category_id
    return if object.category.blank?
    return if object.category.parent.blank?
    category.parent.id
  end

  def date_actual_date format = :date
    return if object.date_actual.blank?
    I18n.l object.date_actual, format: format
  end

  def date_actual_time
    return if object.date_actual.blank?
    I18n.l object.date_actual, format: :timeofday
  end

  def date_interval_from_date format = :date
    return if object.date_interval_from.blank?
    I18n.l object.date_interval_from, format: format
  end

  def date_interval_to_date format = :date
    return if object.date_interval_to.blank?
    I18n.l object.date_interval_to, format: format
  end

  def human_date format = :date_with_words
    case object.date_type
      when 'end_at', 'start_at' then date_actual_date(format)
      when 'interval' then "#{date_interval_from_date(format)} - #{date_interval_to_date(format)}"
    end
  end

  def date_time_left
    date_now = DateTime.now.utc
    case object.date_type
      when 'end_at'
        return if object.date_actual.blank?
        return I18n.t('task.time_is_over') if object.date_actual < date_now
        formatted_time_left object.date_actual.to_i - date_now.to_i
      when 'interval'
        return if object.date_interval_to.blank?
        return I18n.t('task.time_is_over') if object.date_interval_to < date_now
        formatted_time_left object.date_interval_to.to_i - date_now.to_i
    end
  end

  def formatted_time_left total_seconds
    hours = total_seconds / (60 * 60)
    minutes = (total_seconds / 60) % 60
    seconds = total_seconds % 60
    format('%02d:%02d:%02d', hours, minutes, seconds)
  end

  def place_coordinates
    [place_lat, place_long]
  end
end
