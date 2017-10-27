class My::DelocoinController < My::ApplicationController
  decorates_assigned :packs, :pack

  def index
    @current_delocoin_cost = Delocoin::ConvertService.new.delocoins_to_balance(step: current_delocoin_step, delocoins: 1)

    @steps = Delocoin::Step.order('number ASC').all
  end
end
