class My::BillingController < My::ApplicationController
  include Pundit

  decorates_assigned :deposit, :model

  def index
    run Billing::YandexKassa::Deposit::Operation::Create::Present
  end

  def create
    run Billing::YandexKassa::Deposit::Operation::Create, params[:billing_yandex_kassa_deposit] do |result|
      return redirect_to confirm_my_billing_path(id: result['model'][:uuid])
    end

    render 'index'
  end

  def confirm
    @deposit = Billing::YandexKassa::Deposit.find_by(uuid: params[:id])

    authorize @deposit
    apply_model_by_deposit
    @fields = Billing::YandexKassa::RequestFieldsService.new(@deposit).perform
  end

  def success
    @deposit = Billing::YandexKassa::Deposit.find_by(uuid: order_number)

    authorize @deposit
    apply_model_by_deposit

    render :status
  end

  def fail
    @deposit = Billing::YandexKassa::Deposit.find_by(uuid: order_number)

    authorize @deposit
    run Billing::YandexKassa::Deposit::Operation::Fail, id: @deposit.id
    apply_model_by_deposit

    render :status
  end

  def status
    @model = User::BillingLog.find(params[:billing_id])

    authorize @model
  end

  def history
    @billing_logs = current_user.billing_logs.latest.limit(20)
  end

  private

    def order_number
      params[:ordernumber].present? ? params[:ordernumber] : params[:orderNumber]
    end

    def apply_model_by_deposit
      @model = @deposit.billing_log
    end
end
