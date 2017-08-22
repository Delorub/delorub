class ProfileDecorator < Draper::Decorator
  decorates Profile
  delegate_all

  def main_category_id
    return unless object.categories.length.positive?
    return object.categories.first.parent_id if object.categories.first.parent
    object.categories.first.id
  end

  def price
    case object.price_type
      when 'hourly' then I18n.t(:profile_price, price: object.price_hourly)
      when 'project' then I18n.t(:profile_price, price: object.price_project)
    end
  end
end
