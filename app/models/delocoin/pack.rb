# == Schema Information
#
# Table name: delocoin_packs
#
#  id       :integer          not null, primary key
#  cost     :integer
#  discount :float
#  number   :integer
#

class Delocoin::Pack < ApplicationRecord
  self.table_name = 'delocoin_packs'

  validates :cost, :discount, presence: true

  after_save do
    Delocoin::Pack::SortService.new.perform
  end
end
