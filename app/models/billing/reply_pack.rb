# == Schema Information
#
# Table name: billing_reply_packs
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

class Billing::ReplyPack < ApplicationRecord
  self.table_name = 'billing_reply_packs'

  include Billing::Base
  include Billing::Costable
  include Billing::Packable

  has_many :replies

  def name
    'Пакет ответов'
  end
end
