class My::BillingController < My::ApplicationController
  before_action :deposit_present?, only: [:confirm, :processing]
  before_action :deposit_present_with_yandex?, only: [:success, :fail]
  before_action :billing_log_present?, only: [:success, :fail, :confirm]

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
    not_found unless @billing_log.new?
  end

  def processing; end

  def success
    redirect_to processing_my_billing_path(id: @deposit.uuid) if @billing_log.new?
  end

  def fail
    run Billing::YandexKassa::Deposit::Operation::Fail, id: @deposit.id if @billing_log.new?
  end

  def history
    @billing_logs = current_user.billing_logs.latest.limit(20)
  end

  private

    def deposit_present?
      @deposit = current_user.billing_yandex_kassa_deposits.find_by(uuid: params[:id])
      not_found if @deposit.blank?
    end

    def deposit_present_with_yandex?
      params_uuid = params[:ordernumber].present? ? params[:ordernumber] : params[:orderNumber]
      @deposit = current_user.billing_yandex_kassa_deposits.find_by(uuid: params_uuid)
      not_found if @deposit.blank?
    end

    def billing_log_present?
      @billing_log = @deposit.billing_log
      not_found if @billing_log.blank?
    end
end
