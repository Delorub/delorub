require 'disposable/twin/struct'

class ActiveAdmin::CategorySettingsForm < BaseForm
  model :category

  property :settings,
    prepopulator: ->(options) {
      settings.price_ranges = [] if settings.price_ranges.nil?
      settings.price_ranges << OpenStruct.new(title: '', price: '')
    } do
    include Struct

    collection :price_ranges do
      include Struct
      property :title
      property :price
    end
  end
end
