module SeoSettingsHelper
  def formatted_seo_settings_value settings, text, category, place, key
    if parse_seo_settings(settings, key).present?
      parse_seo_settings(settings, key)
    else
      "#{text} #{default_seo_value_by_key(category, place, key, settings)}"
    end
  end

  def default_seo_value_by_key category, city, key, settings = nil
    "#{category.present? ? format(' в категории "%s"', parse_seo_settings(settings, key, category.title)) : ''}
    #{city.present? ? format(' в городе %s', city.name) : ''}"
  end

  def parse_seo_settings settings, key, default_value = ''
    settings.present? && settings.settings.dig(key).present? ? settings.settings.dig(key) : default_value
  end

  def put_seo_h1 text
    content_for :h1, text
  end

  def get_seo_h1 default_text
    content_for?(:h1) ? content_for(:h1) : default_text
  end
end
