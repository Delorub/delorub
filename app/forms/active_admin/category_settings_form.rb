require 'disposable/twin/struct'

class ActiveAdmin::CategorySettingsForm < BaseForm
  model :category

  property :settings,
    prepopulator: ->(options) {
      #if settings.price_ranges.nil?
        settings.price_ranges = [] if settings.price_ranges.nil?
        settings.price_ranges << OpenStruct.new(title: '', price: '', header: '', meta_keys: '')
      #end
    } do
    include Struct
    collection :price_ranges do
      include Struct
      property :title
      property :price
      property :header
      property :meta_keys
    end
  end
end
