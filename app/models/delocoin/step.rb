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

class Delocoin::Step < ApplicationRecord
  self.table_name = 'delocoin_steps'

  validates :date_from, :rate, presence: true

  after_save do
    Delocoin::Step::SortService.new.perform
    Delocoin::Step::SetCurrentService.new.perform
  end
end
