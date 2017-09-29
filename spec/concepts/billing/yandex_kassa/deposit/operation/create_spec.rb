describe Billing::YandexKassa::Deposit::Operation::Create do
  let(:instance) { described_class }

  let(:user) { create :user }

  describe '#call' do
    let(:accept_terms) { '1' }
    let(:pay_type) { 'qiwi' }
    let(:amount) { 100 }

    let(:params) { { pay_type: pay_type, accept_terms: accept_terms, amount: amount } }
    let(:options) { { 'current_user' => user } }

    subject { described_class.call(params, options) }

    shared_examples 'not to change user balance' do
      specify { expect { subject }.not_to(change { user.reload.balance }) }
    end

    shared_examples 'creates new yandex deposit and billing log' do
      specify { expect { subject }.to(change { Billing::YandexKassa::Deposit.count }) }
      specify { expect { subject }.to(change { User::BillingLog.count }) }
    end

    shared_examples 'not creates new yandex deposit and new billing log' do
      specify { expect { subject }.not_to(change { Billing::YandexKassa::Deposit.count }) }
      specify { expect { subject }.not_to(change { User::BillingLog.count }) }
    end

    shared_examples 'not create new billing log' do
      specify { expect { subject }.not_to(change { User::BillingLog.count }) }
    end

    context 'no pay type selected' do
      let(:pay_type) { nil }

      it { assert subject.failure? }
      it_behaves_like 'not creates new yandex deposit and new billing log'
      it_behaves_like 'not to change user balance'
    end

    context 'no user specified' do
      let(:user) { nil }

      it { assert subject.failure? }
      it_behaves_like 'not create new billing log'
    end

    context 'no amount specified' do
      let(:amount) { nil }

      it { assert subject.failure? }
      it_behaves_like 'not creates new yandex deposit and new billing log'
      it_behaves_like 'not to change user balance'
    end

    context 'paying from different types' do
      context 'visa' do
        let(:pay_type) { 'visa' }
        it { assert subject.success? }
        it_behaves_like 'not to change user balance'
        it_behaves_like 'creates new yandex deposit and billing log'
      end

      context 'qiwi' do
        let(:pay_type) { 'qiwi' }
        it { assert subject.success? }
        it_behaves_like 'not to change user balance'
        it_behaves_like 'creates new yandex deposit and billing log'
      end

      context 'webmoney' do
        let(:pay_type) { 'webmoney' }
        it { assert subject.success? }
        it_behaves_like 'not to change user balance'
        it_behaves_like 'creates new yandex deposit and billing log'
      end

      context 'yandex' do
        let(:pay_type) { 'yandex' }
        it { assert subject.success? }
        it_behaves_like 'not to change user balance'
        it_behaves_like 'creates new yandex deposit and billing log'
      end
    end
  end
end
