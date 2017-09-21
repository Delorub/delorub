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

  def success; end

  def fail
    run Billing::YandexKassa::Deposit::Operation::Fail, id: @deposit.id
  end

  def history
    @billing_logs = current_user.billing_logs.latest.limit(20)
  end

  private

    def deposit_present?
      run Billing::YandexKassa::Deposit::Operation::Find, uuid: params[:id] do |result|
        @deposit = result['model']
      end
      not_found if @deposit.blank?
    end

    def deposit_present_with_yandex?
      params_uuid = params[:ordernumber].present? ? params[:ordernumber] : params[:orderNumber]
      run Billing::YandexKassa::Deposit::Operation::Find, uuid: params_uuid do |result|
        @deposit = result['model']
      end
      not_found if @deposit.blank?
    end
end
