class DelocoinsController < ApplicationController
  helper_method :last_step, :last_step_delocoin_cost, :current_step_delocoin_cost, :packs

  def new
    run Billing::Delocoin::Buy::Operation::Create::Present
    render 'my/delocoin/buy' if user_signed_in?
  end

  def create
    run Billing::Delocoin::Buy::Operation::Create, delocoin_params do |result|
      sign_in result['sign_in_new_user'] if result['sign_in_new_user']

      payment_model = if result['nested_payment'].present?
                        result['nested_payment']['model']
                      else
                        result['model']
                      end

      roistat.push_async(:delocoin_buy_create, cost: result['model'].cost)
      return redirect_to confirm_my_billing_path(id: payment_model.billing_log.id)
    end

    return render 'my/delocoin/buy' if user_signed_in?
    render 'new'
  end

  private

    def delocoin_params
      params.require(:billing_delocoin_buy).permit!
    end

    def packs
      @packs = if user_signed_in?
                 Delocoin::Pack.order('cost ASC').decorate
               else
                 Delocoin::Pack.is_public.order('cost ASC').decorate
               end
    end

    def last_step
      @last_step = Delocoin::Step::LastService.new.perform
    end

    def last_step_delocoin_cost
      @last_step_delocoin_cost = Delocoin::ConvertService.new.delocoins_to_balance(step: last_step, delocoins: 1)
    end

    def current_step_delocoin_cost
      @current_step_delocoin_cost = Delocoin::ConvertService.new.delocoins_to_balance(step: current_delocoin_step, delocoins: 1)
    end
end
