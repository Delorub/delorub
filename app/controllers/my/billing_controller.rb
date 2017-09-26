class My::BillingController < My::ApplicationController
  include Pundit

  decorates_assigned :model, :billable

  def index
    run Billing::YandexKassa::Deposit::Operation::Create::Present
  end

  def create
    run Billing::YandexKassa::Deposit::Operation::Create, params[:billing_yandex_kassa_deposit] do |result|
      return redirect_to confirm_my_billing_path(id: result['model'].billing_log.id)
    end

    render 'index'
  end

  # TODO: split this method to services
  def confirm
    @model = User::BillingLog.find params[:id]
    @billable = @model.billable

    authorize @model

    if request.post?
      case @billable.pay_type.to_sym
        when *Billing::PaymentTypeList::BALANCE
          case @billable.class.name
            when 'Billing::Delocoin::Buy'
              run Billing::Delocoin::Buy::Operation::Finish, id: @billable.id
              return redirect_to status_my_billing_path(@model.billing_log.id)
          end
      end

      not_found
    end

    case @billable.pay_type.to_sym
      when *Billing::PaymentTypeList::YANDEX_KASSA
        @fields = Billing::YandexKassa::RequestFieldsService.new(@billable).perform

        render 'my/billing/confirm/yandex_kassa'
      when *Billing::PaymentTypeList::BALANCE
        render 'my/billing/confirm/balance'
      else
        not_found
    end
  end

  def status
    @model = User::BillingLog.find params[:id]

    authorize @model
  end

  # TODO: move this method to Yandex Endpoint controller
  def success
    @deposit = Billing::YandexKassa::Deposit.find_by(uuid: order_number)
    authorize @deposit

    redirect_to status_my_billing_path(@deposit.billing_log.id)
  end

  # TODO: move this method to Yandex Endpoint controller
  def fail
    @deposit = Billing::YandexKassa::Deposit.find_by(uuid: order_number)
    authorize @deposit

    run Billing::YandexKassa::Deposit::Operation::Fail, id: @deposit.id

    redirect_to status_my_billing_path(@deposit.billing_log.id)
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
