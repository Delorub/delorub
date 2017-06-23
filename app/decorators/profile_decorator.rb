class ProfileDecorator < Draper::Decorator
  decorates Profile
  delegate_all

  def main_category_id
    return unless object.categories.length.positive?
    return object.categories.first.parent_id if object.categories.first.parent
    object.categories.first.id
  end
end
