require 'disposable/twin/struct'

class ActiveAdmin::CategorySettingsForm < BaseForm
  model :category

  property :settings,
    prepopulator: ->(options) {
      if settings.price_ranges.nil?
        settings.price_ranges = [] if settings.price_ranges.nil?
        settings.price_ranges << OpenStruct.new(title: '', price: '', h1: '', seo_title: '', seo_description: '', seo_key_words: '')
      end
    } do
    include Struct
    collection :price_ranges do
      include Struct
      property :h1
      property :seo_title
      property :seo_description
      property :seo_key_words
      property :title
      property :price
    end
  end
end
