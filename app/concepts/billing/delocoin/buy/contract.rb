class Billing::Delocoin::Buy::Contract < Reform::Form
  property :pack_id,
    prepopulator: ->(options) {
      pack_10_000 = Delocoin::Pack.find_by(cost: 10_000)
      if pack_10_000.present?
        self.pack_id = pack_10_000.id
        return
      end

      self.pack_id = Delocoin::Pack.first.id
    },
    populator: ->(fragment:, **) {
      self.pack_id = Delocoin::Pack.find_by(id: fragment).try(:id)
    }

  property :pay_type,
    default: 'balance',
    populator: ->(fragment:, **_) {
      self.pay_type = Billing::PaymentTypeList.for(model).detect { |e| e == fragment.to_sym }
    }

  property :accept_terms, virtual: true, default: false

  validates :pack_id, :pay_type, presence: true
  validates :accept_terms, presence: true
  validates :accept_terms, inclusion: { in: ['1'], message: 'Вы должны согласиться с правилами сервиса' }

  def pack
    ::Delocoin::Pack.find_by id: pack_id
  end
end
