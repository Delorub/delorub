describe Billing::YandexKassa::Deposit::Operation::Finish do
  include YandexKassaHelpers
  let(:instance) { described_class }

  let(:user) { create :user, balance: 100 }
  let(:state) { :new }

  let(:billing_yandex_deposit) { create :billing_yandex_kassa_deposit, amount: 100, pay_type: 'qiwi', user: user, state: state }

  describe '#call' do
    let(:params) { generate_yandex_hash(billing_yandex_deposit, 'paymentAviso') }

    subject { described_class.call(params) }

    shared_examples 'change user balance' do
      specify { expect { subject }.to(change { user.reload.balance }.by(billing_yandex_deposit.amount)) }
    end

    shared_examples 'not to change user balance' do
      specify { expect { subject }.not_to(change { user.reload.balance }) }
    end

    context 'valid' do
      it { assert subject.success? }
      it_behaves_like 'change user balance'
    end

    context 'not valid' do
      let(:params) { generate_yandex_hash(billing_yandex_deposit, 'paymentAviso', true) }

      it { assert subject.failure? }
      it_behaves_like 'not to change user balance'
    end

    context 'already finished' do
      let(:state) { :finished }

      it { assert subject.failure? }
      it_behaves_like 'not to change user balance'
    end

    context 'already failed' do
      let(:state) { :failed }

      it { assert subject.failure? }
      it_behaves_like 'not to change user balance'
    end
  end
end
