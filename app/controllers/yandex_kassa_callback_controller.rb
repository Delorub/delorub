class YandexKassaCallbackController < ApplicationController
  def success
    # TODO: change it to the right way, move to API
    some_id = Billing::YandexKassa::Deposit.last.id

    run Billing::YandexKassa::Deposit::Operation::Finish, id: some_id do |result|
      return render text: 'ok'
    end

    render text: 'fail'
  end
end
