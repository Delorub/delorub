# == Schema Information
#
# Table name: delocoin_steps
#
#  id         :integer          not null, primary key
#  date_from  :date
#  rate       :float
#  is_current :boolean
#  number     :integer
#

FactoryGirl.define do
  factory :delocoin_step, class: Delocoin::Step do
    date_from { Time.zone.yesterday }
    rate 1
  end
end
