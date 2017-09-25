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
    run Billing::Delocoin::Buy::Operation::Confirm, id: params[:id]

    return redirect_to my_billing_status_path(billing_id: result['model'].billing_log.id)
  end

  private

    def buy_new
      run Billing::Delocoin::Buy::Operation::Create::Present
    end

    def buy_create
      run Billing::Delocoin::Buy::Operation::Create, params[:billing_delocoin_buy] do |result|
        run Billing::Delocoin::Buy::Operation::Confirm::Present, id: result['model'].id

        render 'confirm'
      end
    end
end
