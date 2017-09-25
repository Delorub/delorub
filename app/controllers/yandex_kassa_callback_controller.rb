class YandexKassaCallbackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def processing
    run Billing::YandexKassa::Deposit::Operation::Finish, params do |result|
      return render plain: Billing::YandexKassa::ResponseService.new(params['invoiceId'], 0).aviso_response
    end
    render plain: Billing::YandexKassa::ResponseService.new(params['invoiceId'], 1).aviso_response
  end

  def check
    run Billing::YandexKassa::Deposit::Operation::Check, params do |result|
      return render plain: Billing::YandexKassa::ResponseService.new(params['invoiceId'], 0).check_response
    end
    render plain: Billing::YandexKassa::ResponseService.new(params['invoiceId'], 100).check_response
  end
end
