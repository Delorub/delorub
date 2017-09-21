# == Schema Information
#
# Table name: delocoin_steps
#
#  id         :integer          not null, primary key
#  date_from  :date
#  rate       :float
#  is_current :boolean
#

class Delocoin::Step < ApplicationRecord
  self.table_name = 'delocoin_steps'
end
