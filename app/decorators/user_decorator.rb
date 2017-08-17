class UserDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  decorates Profile
  delegate_all

  def age
    object.birthday.present? ? distance_of_time_in_words(object.birthday, DateTime.current) : I18n.t(:not_specified)
  end

  def city_name
    object.place.present? ? object.place.name : I18n.t(:not_specified)
  end
end
