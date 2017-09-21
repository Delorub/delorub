class My::DelocoinController < My::ApplicationController
  decorates_assigned :packs, :pack

  def buy
    @current_delocoin_cost = Delocoin::Step::ConvertService.new.delocoins_to_balance(step: current_delocoin_step, delocoins: 1)
    @last_step = Delocoin::Step::LastService.new.perform
    @packs = Delocoin::Pack.order('cost ASC').decorate
  end
end
