class ProfileDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper
  decorates_association :user
  decorates Profile
  delegate_all

  def main_category_id
    return unless object.categories.length.positive?
    return object.categories.first.parent_id if object.categories.first.parent
    object.categories.first.id
  end

  def formatted_age
    object.birthday.present? ? distance_of_time_in_words(object.birthday, DateTime.current, only: :years) : I18n.t(:not_specified)
  end

  def formatted_city_name
    object.place.present? ? object.place.name : I18n.t(:not_specified)
  end

  def formatted_price
    price_project.present? ? I18n.t('profile.price_from', price: price_project) : I18n.t('profile.price_not_specified')
  end

  def subcategories_by_main_category main_category_id
    categories.where(parent_id: main_category_id)
  end
end
