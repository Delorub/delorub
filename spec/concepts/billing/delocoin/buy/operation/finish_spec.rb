describe Billing::Delocoin::Buy::Operation::Finish do
  let(:instance) { described_class }

  let(:pack_cost) { 100 }
  let(:user_balance) { 150 }
  let(:state) { :new }

  let!(:pack) { create :delocoin_pack, cost: pack_cost }
  let!(:step) { create :delocoin_step }
  let(:user) { create :user, balance: user_balance }

  let(:billing_delocoin_buy) { create :billing_delocoin_buy, pack: pack, step: step, user: user, state: state }

  describe '#call' do
    let(:params) { { id: billing_delocoin_buy.id } }
    let(:options) { { 'current_user' => user } }

    subject { described_class.call(params, options) }

    shared_examples 'change user balance and delocoin balance' do
      specify { expect { subject }.to change { user.reload.balance }.by(-billing_delocoin_buy.cost) }
      specify { expect { subject }.to change { user.reload.delocoin_balance }.by(billing_delocoin_buy.delocoin_amount) }
    end

    # TODO: move to global shared examples?
    shared_examples 'not to change user balance and delocoin balance' do
      specify { expect { subject }.not_to change { user.reload.balance } }
      specify { expect { subject }.not_to change { user.reload.delocoin_balance } }
    end

    context 'valid' do
      it { assert subject.success? }
      it_behaves_like 'change user balance and delocoin balance'
    end

    context 'zero balance' do
      let(:user_balance) { 0 }

      it { assert subject.failure? }
      it_behaves_like 'not to change user balance and delocoin balance'
    end

    context 'already finished' do
      let(:state) { :finished }

      it { assert subject.failure? }
      it_behaves_like 'not to change user balance and delocoin balance'
    end

    context 'already failed' do
      let(:state) { :failed }

      it { assert subject.failure? }
      it_behaves_like 'not to change user balance and delocoin balance'
    end

    context 'different current_user' do
      let(:options) { { 'current_user' => create(:user) } }

      it { assert subject.failure? }
      it_behaves_like 'not to change user balance and delocoin balance'
    end

    context 'not enough balance' do
      let(:user_balance) { pack_cost - 1 }

      it { assert subject.failure? }
      it_behaves_like 'not to change user balance and delocoin balance'
    end

    context 'same balance' do
      let(:user_balance) { pack_cost }

      it { assert subject.success? }
      it_behaves_like 'change user balance and delocoin balance'
    end
  end
end
