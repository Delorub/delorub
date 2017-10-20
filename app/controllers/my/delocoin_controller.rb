class My::DelocoinController < My::ApplicationController
  decorates_assigned :packs, :pack

  def index
    @current_delocoin_cost = Delocoin::ConvertService.new.delocoins_to_balance(step: current_delocoin_step, delocoins: 1)

    @steps = Delocoin::Step.order('number ASC').all
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

  private

    def buy_new
      run Billing::Delocoin::Buy::Operation::Create::Present
    end

    def buy_create
      run Billing::Delocoin::Buy::Operation::Create, params[:billing_delocoin_buy] do |result|
        payment_model = if result['nested_payment'].present?
                          result['nested_payment']['model']
                        else
                          result['model']
                        end

        roistat.push_async(:delocoin_buy_create, cost: result['model'].cost)
        redirect_to confirm_my_billing_path(id: payment_model.billing_log.id)
      end
    end
end
