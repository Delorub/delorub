class User::OmniauthRelationDecorator < Draper::Decorator
  decorates User::OmniauthRelation
  delegate_all

  def provider_url
    return if data.info.urls.nil?
    data.info.urls.first[1]
  end

  def provider_url_without_http
    return if provider_url.nil?
    provider_url.gsub('http://', '').gsub('https://', '')
  end
end
