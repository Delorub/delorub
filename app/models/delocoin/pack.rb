# == Schema Information
#
# Table name: delocoin_packs
#
#  id       :integer          not null, primary key
#  cost     :integer
#  discount :float
#

class Delocoin::Pack < ApplicationRecord
  self.table_name = 'delocoin_packs'
end
