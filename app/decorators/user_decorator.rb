class UserDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  decorates User
  delegate_all

  def age
    object.birthday.present? ? distance_of_time_in_words(object.birthday, DateTime.current) : nil
  end

  def formatted_age
    age.blank? ? I18n.t(:not_specified) : age
  end

  def city_name
    object.place.present? ? object.place.name : I18n.t(:not_specified)
  end
end
