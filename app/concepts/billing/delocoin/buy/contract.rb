module Billing::Delocoin::Buy::Contract
  class Form < ::BaseForm
    def pack
      ::Delocoin::Pack.find_by id: pack_id
    end
  end

  class GuestForm < Form
    property :pack_id,
      prepopulator: ->(options) {
        pack_public = Delocoin::Pack.find_by(cost: 10_000)
        self.pack_id = pack_public.present? ? pack_public.id : Delocoin::Pack.first.id
      },
      populator: ->(fragment:, **) {
        self.pack_id = Delocoin::Pack.is_public.find_by(id: fragment).try(:id)
      }

    property :pay_type,
      default: 'visa',
      populator: ->(fragment:, **_) {
        self.pay_type = Billing::PaymentTypeList.for(Billing::YandexKassa::Deposit).detect { |e| e == fragment.to_sym }
      }

    property :new_user,
      prepopulator: ->(options) { self.new_user = User.new },
      populator: ->(model:, **) { model || self.new_user = User.new },
      form: User::Contract::InlineRegistration,
      virtual: true

    validation :default do
      configure do
        config.messages = :i18n
      end

      required(:pack_id).filled
      required(:pay_type).filled
    end
  end

  class UserForm < Form
    property :pack_id,
      prepopulator: ->(options) {
        pack_select = Delocoin::Pack.find_by(cost: 10_000)
        if pack_select.present?
          self.pack_id = pack_select.id
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

    validation :default do
      configure do
        config.messages = :i18n
      end

      required(:pack_id).filled
      required(:pay_type).filled
      required(:accept_terms).filled(included_in?: ['1'])
    end
  end
end
