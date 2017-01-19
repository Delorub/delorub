class Profile < ActiveRecord::Base
  extend Enumerize
  
  belongs_to :user

  enumerize :work_type, in: [:single, :company, :team]
  enumerize :pay_type, in: [:cash, :emoney, :card, :other]
  enumerize :car_type, in: [:passenger, :truck, :none]
end
