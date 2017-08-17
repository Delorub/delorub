class CategoryDecorator < Draper::Decorator
  decorates Category
  delegate_all

  def settings_value(params)
    object.settings.present? ? object.settings[params] : ''
  end

end
