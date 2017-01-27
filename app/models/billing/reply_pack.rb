class Billing::ReplyPack < ActiveRecord::Base
  self.table_name = 'billing_reply_packs'
  
  include Billing::Base
  include Billing::Costable
  include Billing::Packable
  
  has_many :replies
  
  def name
    "Пакет ответов"
  end
end
