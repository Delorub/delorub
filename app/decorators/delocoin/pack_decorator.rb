class Delocoin::PackDecorator < Draper::Decorator
  decorates Delocoin::Pack
  delegate_all

  def discount_in_percents
    ((1 - discount) * 100).to_i
  end

  def one_delocoin_cost
    Delocoin::ConvertService.new.delocoins_to_balance(step: current_step, pack: object, delocoins: 1)
  end

  def delocoin_amount
    Delocoin::ConvertService.new.balance_to_delocoins(step: current_step, pack: object, balance: cost).to_i
  end

  def delocoin_cost_on_last_step
    Delocoin::ConvertService.new.delocoins_to_balance(step: last_step, delocoins: delocoin_amount).to_i
  end

  private

    def current_step
      Delocoin::Step::CurrentService.new.perform
    end

    def last_step
      Delocoin::Step::LastService.new.perform
    end
end
