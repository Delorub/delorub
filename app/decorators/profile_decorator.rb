class ProfileDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  decorates Profile
  delegate_all

  def main_category_id
    return unless object.categories.length.positive?
    return object.categories.first.parent_id if object.categories.first.parent
    object.categories.first.id
  end

  def age
    object.birthday.present? ? distance_of_time_in_words(object.birthday, DateTime.current) : nil
  end

  def formatted_age
    age.present? ? age : I18n.t(:not_specified)
  end

  def formatted_city_name
    object.city_name.present? ? object.city_name : I18n.t(:not_specified)
  end

  def formatted_price
    object.price_project.present? ? I18n.t(:profile_price, price: object.price_project) : I18n.t(:price_unknown)
  end
end
