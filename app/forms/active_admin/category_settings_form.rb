require 'disposable/twin/struct'

class ActiveAdmin::CategorySettingsForm < BaseForm
  model :category

  property :settings,
    prepopulator: ->(options) {
      settings.price_ranges = [] if settings.price_ranges.nil?
      settings.price_ranges << OpenStruct.new(title: '', price: '')
    } do
    include Disposable::Twin::Property::Struct
    property :h1
    property :seo_title
    property :seo_description
    property :seo_keywords

    collection :price_ranges do
      include Disposable::Twin::Property::Struct
      property :title
      property :price
    end
  end
end
