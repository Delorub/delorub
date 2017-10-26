describe Billing::Delocoin::Buy::Operation::Create do
  let(:instance) { described_class }

  let!(:pack) { create :delocoin_pack }
  let(:pack_id) { pack.id }
  let!(:step) { create :delocoin_step }
  let(:balance) { 1000 }
  let(:user) { create :user, balance: balance }

  describe '#call' do
    let(:accept_terms) { '1' }
    let(:pay_type) { 'balance' }

    let(:params) { { pack_id: pack_id, pay_type: pay_type, accept_terms: accept_terms }.as_json }
    let(:options) { { 'current_user' => user } }

    subject { described_class.call(params, options) }

    # TODO: move to global shared examples?
    shared_examples 'not to change user balance and delocoin balance' do
      specify { expect { subject }.not_to(change { user.reload.balance }) }
      specify { expect { subject }.not_to(change { user.reload.delocoin_balance }) }
    end

    shared_examples 'creates new billing log' do
      specify { expect { subject }.to(change { Billing::Delocoin::Buy.count }) }
      specify { expect { subject }.to(change { User::BillingLog.count }) }
    end

    shared_examples 'not creates new billing log' do
      specify { expect { subject }.not_to(change { User::BillingLog.count }) }
    end

    shared_examples 'creates yandex_kassa model' do
      specify { expect { subject }.to(change { Billing::YandexKassa::Deposit.count }) }
    end

    context 'no pay type selected' do
      let(:pay_type) { nil }

      it { assert subject.failure? }
      it_behaves_like 'not to change user balance and delocoin balance'
      it_behaves_like 'not creates new billing log'
    end

    context 'no user specified' do
      let(:user) { nil }

      it { assert subject.failure? }
      it_behaves_like 'not creates new billing log'
    end

    context 'paying from balance' do
      let(:pay_type) { 'balance' }

      context 'valid' do
        it { assert subject.success? }
        it_behaves_like 'not to change user balance and delocoin balance'
        it_behaves_like 'creates new billing log'
      end

      context 'insufficient funds on the balance' do
        let(:balance) { 0 }

        it { assert subject.failure? }
        it_behaves_like 'not to change user balance and delocoin balance'
        it_behaves_like 'not creates new billing log'
      end

      context 'not accepting terms' do
        let(:accept_terms) { nil }

        it { assert subject.failure? }
        it_behaves_like 'not to change user balance and delocoin balance'
        it_behaves_like 'not creates new billing log'
      end

      context 'no pack selected' do
        let(:pack_id) { nil }

        it { assert subject.failure? }
        it_behaves_like 'not to change user balance and delocoin balance'
        it_behaves_like 'not creates new billing log'
      end
    end

    context 'paying from different types' do
      context 'pay_type is not balance and insufficient funds on the balance' do
        let(:pay_type) { 'visa' }
        let(:balance) { 0 }

        it { assert subject.success? }
        it_behaves_like 'not to change user balance and delocoin balance'
        it_behaves_like 'creates new billing log'
        it_behaves_like 'creates yandex_kassa model'
      end

      context 'visa' do
        let(:pay_type) { 'visa' }

        it { assert subject.success? }
        it_behaves_like 'not to change user balance and delocoin balance'
        it_behaves_like 'creates new billing log'
        it_behaves_like 'creates yandex_kassa model'
      end

      context 'yandex' do
        let(:pay_type) { 'yandex' }
        it { assert subject.success? }
        it_behaves_like 'not to change user balance and delocoin balance'
        it_behaves_like 'creates new billing log'
        it_behaves_like 'creates yandex_kassa model'
      end
    end
  end
end
