class My::BillingController < My::ApplicationController
  include Pundit

  before_action :deposit_present?, only: [:confirm]
  before_action :deposit_present_with_yandex?, only: [:success, :fail]

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
    authorize @deposit
  end

  def success
    authorize @deposit
  end

  def fail
    authorize @deposit

    run Billing::YandexKassa::Deposit::Operation::Fail, id: @deposit.id
  end
  
  def status
    @model = User::BillingLog.find(params[:billing_id]).decorate

    authorize @model
  end

  def history
    @billing_logs = current_user.billing_logs.latest.limit(20)
  end

  private

    def deposit_present?
      @deposit = current_user.billing_yandex_kassa_deposits.find_by(uuid: params[:id])
    end

    def deposit_present_with_yandex?
      params_uuid = params[:ordernumber].present? ? params[:ordernumber] : params[:orderNumber]
      @deposit = current_user.billing_yandex_kassa_deposits.find_by(uuid: params_uuid)
    end
end
