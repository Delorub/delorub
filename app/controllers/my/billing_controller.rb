class My::BillingController < My::ApplicationController
  def index
    run Billing::YandexKassa::Deposit::Operation::Create::Present
  end

  def create
    run Billing::YandexKassa::Deposit::Operation::Create, params[:billing_yandex_kassa_deposit] do |result|
      # TODO: this is stub, remove it when integrate to yandex kassa
      some_id = Billing::YandexKassa::Deposit.last.id
      run Billing::YandexKassa::Deposit::Operation::Finish, id: some_id

      return redirect_to my_billing_index_path, notice: 'Перенаправляем на яндекс кассу'
    end

    render 'index'
  end

  def history
    @billing_logs = current_user.billing_logs.latest.limit(20)
  end
end
