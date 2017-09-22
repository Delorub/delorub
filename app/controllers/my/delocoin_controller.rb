class My::DelocoinController < My::ApplicationController
  decorates_assigned :packs, :pack

  def index
    @current_delocoin_cost = Delocoin::ConvertService.new.delocoins_to_balance(step: current_delocoin_step, delocoins: 1)
  end

  def buy
    @last_step = Delocoin::Step::LastService.new.perform
    @last_step_delocoin_cost = Delocoin::ConvertService.new.delocoins_to_balance(step: @last_step, delocoins: 1)
    @current_step_delocoin_cost = Delocoin::ConvertService.new.delocoins_to_balance(step: current_delocoin_step, delocoins: 1)

    @packs = Delocoin::Pack.order('cost ASC').decorate

    if request.post?
      buy_create
    else
      buy_new
    end
  end

  def confirm
    if request.post?
      confirm_create
    else
      confirm_new
    end
  end

  private

    def buy_new
      run Billing::Delocoin::Buy::Operation::Create::Present
    end

    def buy_create
      run Billing::Delocoin::Buy::Operation::Create, params[:billing_delocoin_buy] do |result|
        return redirect_to confirm_my_delocoin_index_path(id: result['model'].id)
      end
    end

    def confirm_new
      run Billing::Delocoin::Buy::Operation::Confirm::Present, id: params[:id]
    end

    def confirm_create
      run Billing::Delocoin::Buy::Operation::Confirm, id: params[:id] do |result|
        return redirect_to my_delocoin_index_path
      end
    end
end
