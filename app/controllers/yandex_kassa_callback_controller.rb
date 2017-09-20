class YandexKassaCallbackController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_deposit, only: [:processing]

  def processing
    aviso = Billing::YandexKassa::PaymentAvisoService.new(params)
    return render plain: aviso.response(200) if @deposit.blank?

    if aviso.valid_signature?
      run Billing::YandexKassa::Deposit::Operation::Finish, id: @deposit.id do |result|
        return render plain: aviso.response
      end
    else
      run Billing::YandexKassa::Deposit::Operation::Fail, id: @deposit.id do |result|
        return render plain: aviso.response
      end
    end
    render plain: aviso.response(200)
  end

  def check
    check_order = Billing::YandexKassa::CheckOrderService.new(params)
    check_order.save_params
    render plain: check_order.response
  end

  private

  def find_deposit
    @deposit = Billing::YandexKassa::Deposit.where(uuid: params[:orderNumber]).first if params[:orderNumber]
  end
end
