class Api::V10::YandexKassaCallback < ApplicationAPI
  format :txt

  namespace :billings do
    namespace :process do
      desc 'Yandex kassa process'
      post do
        if run!(Billing::YandexKassa::Deposit::Operation::Finish, params)['success']
          return present Billing::YandexKassa::ResponseService.new(params['invoiceId'], 0).aviso_response
        end
        present Billing::YandexKassa::ResponseService.new(params['invoiceId'], 1).aviso_response
      end
    end

    namespace :check do
      desc 'Yandex kassa check params'
      post do
        if run!(Billing::YandexKassa::Deposit::Operation::Check, params)['success']
          return present Billing::YandexKassa::ResponseService.new(params['invoiceId'], 0).check_response
        end
        present Billing::YandexKassa::ResponseService.new(params['invoiceId'], 100).check_response
      end
    end
  end

  helpers do
    def run! operation_klass, request
      operation_klass.call(request).as_json
    end
  end
end
