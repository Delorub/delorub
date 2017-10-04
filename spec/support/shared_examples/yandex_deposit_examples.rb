shared_examples 'not creates new yandex deposit' do
  specify { expect { subject }.not_to(change { Billing::YandexKassa::Deposit.count }) }
end

shared_examples 'create new yandex deposit' do
  specify { expect { subject }.to(change { Billing::YandexKassa::Deposit.count }) }
end
