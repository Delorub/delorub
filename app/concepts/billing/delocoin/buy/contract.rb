class Billing::Delocoin::Buy::Contract < Reform::Form
  property :pack_id,
    prepopulator: ->(options) {
      self.pack_id = Delocoin::Pack.first.id
    },
    populator: ->(fragment:, **) {
      item = Delocoin::Pack.find_by(id: fragment)
      self.pack_id = item.id if item.present?
    }

  property :pay_type, default: 'balance'
  property :accept_terms, virtual: true, default: false

  validates :pack_id, presence: true

  validates :accept_terms, presence: true
  validates :accept_terms, inclusion: { in: ['1'], message: 'Вы должны согласиться с правилами сервиса' }

  def pack
    ::Delocoin::Pack.find_by id: pack_id
  end
end
