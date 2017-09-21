class YandexKassaCallbackController < ApplicationController
  skip_before_action :verify_authenticity_token

  def processing
    run Billing::YandexKassa::Deposit::Operation::Finish, params do |result|
      return render plain: Billing::YandexKassa::Responce::AvisoService.new(params['invoiceId'], result['responce_code']).response
    end
    render plain: Billing::YandexKassa::Responce::AvisoService.new(params['invoiceId'], 1).response
  end

  def check
    run Billing::YandexKassa::Deposit::Operation::Check, params do |result|
      return render plain: Billing::YandexKassa::Responce::CheckService.new(params['invoiceId'], 0).response
    end
    render plain: Billing::YandexKassa::Responce::CheckService.new(params['invoiceId'], 100).response
  end
end
