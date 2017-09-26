class Billing::CreateNestedPayment
  extend Uber::Callable

  def self.call options, model:, **_
    return true unless model.pay_type.to_sym.in? payment_types
    amount = -options['sum'].to_i

    options['nested_payment'] = Billing::YandexKassa::Deposit::Operation::Create.call(
      {
        amount: amount,
        pay_type: model.pay_type.to_s,
        accept_terms: '1'
      },
      'current_user' => options['current_user']
    )

    # TODO: move to operation
    if options['nested_payment'].success?
      options['nested_payment']['model'].billing_log.finish_after_billing_log_id = model.billing_log.id
      options['nested_payment']['model'].billing_log.save!
      true
    end
  end

  private

    def self.payment_types
      Billing::PaymentTypeList.for(Billing::YandexKassa::Deposit)
    end
end
