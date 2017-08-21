class ProfileDecorator < Draper::Decorator
  decorates Profile
  delegate_all

  def main_category_id
    return unless object.categories.length.positive?
    return object.categories.first.parent_id if object.categories.first.parent
    object.categories.first.id
  end

  def price
    if object.price_type.hourly?
      I18n.t(:profile_price_hourly, price: object.price_hourly)
    else
      I18n.t(:profile_price_project, price: object.price_project)
    end
  end
end
