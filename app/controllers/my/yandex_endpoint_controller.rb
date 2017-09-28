class My::YandexEndpointController < My::ApplicationController
  include Pundit

  def success
    @deposit = Billing::YandexKassa::Deposit.find_by(uuid: order_number)
    authorize @deposit

    redirect_to status_my_billing_path(@deposit.billing_log.id)
  end

  def fail
    @deposit = Billing::YandexKassa::Deposit.find_by(uuid: order_number)
    authorize @deposit

    run Billing::YandexKassa::Deposit::Operation::Fail, id: @deposit.id

    redirect_to status_my_billing_path(@deposit.billing_log.id)
  end

  private

    def order_number
      params[:ordernumber].present? ? params[:ordernumber] : params[:orderNumber]
    end
end
