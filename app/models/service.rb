class Service < ActiveRecord::Base
  extend Enumerize

  enumerize :price_type, in: [:one_time, :hour, :day, :month]
end
