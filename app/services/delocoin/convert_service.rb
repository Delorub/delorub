class Delocoin::ConvertService
  def balance_to_delocoins step:, pack:, balance:
    raise 'It\'s not a step!' unless step.is_a? Delocoin::Step
    raise 'It\'s not a pack!' unless pack.is_a? Delocoin::Pack
    raise 'Value is negative' if balance.negative?

    balance / step.rate / pack_discount(pack)
  end

  def delocoins_to_balance step:, delocoins:, pack: nil
    raise 'It\'s not a step!' unless step.is_a? Delocoin::Step
    raise 'Value is negative' if delocoins.negative?

    delocoins * step.rate * pack_discount(pack)
  end

  private

    def pack_discount pack
      return 1 if pack.nil?
      pack.discount
    end
end
