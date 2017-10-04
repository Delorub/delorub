describe Billing::YandexKassa::Deposit::Operation::Fail do
  include YandexKassaHelper
  let(:instance) { described_class }

  let(:user) { create :user, balance: 100 }
  let(:state) { :new }

  let(:billing_yandex_deposit) { create :billing_yandex_kassa_deposit, amount: 100, pay_type: 'qiwi', user: user, state: state }

  describe '#call' do
    let(:params) { { id: billing_yandex_deposit.id } }

    subject { described_class.call(params) }

    context 'valid' do
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
