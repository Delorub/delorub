# == Schema Information
#
# Table name: billing_task_packs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  cost       :float
#  amount     :integer
#  spent      :integer          default(0), not null
#  available  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Billing::TaskPack < ApplicationRecord
  self.table_name = 'billing_task_packs'

  include Billing::Base
  include Billing::Costable
  include Billing::Packable

  has_many :tasks

  def name
    'Пакет заданий'
  end
end
