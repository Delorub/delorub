describe Billing::Delocoin::Buy::Operation::Finish do
  let(:instance) { described_class }

  let(:pack_cost) { 100 }
  let(:user_balance) { 150 }

  let!(:pack) { create :delocoin_pack, cost: pack_cost }
  let!(:step) { create :delocoin_step }
  let(:user) { create :user, balance: user_balance }

  let(:billing_delocoin_buy) { create :billing_delocoin_buy, pack: pack, step: step, user: user }

  describe '#call' do
    let(:params) { { id: billing_delocoin_buy.id } }
    let(:options) { { 'current_user' => user } }

    subject { described_class.call(params, options) }

    context 'valid' do
      it { assert subject.success? }

      it 'should change user balance' do
        expect { subject }.to change { user.reload.balance }.by(-billing_delocoin_buy.cost)
      end

      it 'should change user delocoin balance' do
        expect { subject }.to change { user.reload.delocoin_balance }.by(billing_delocoin_buy.delocoin_amount)
      end
    end

    context 'different current_user' do
      let(:options) { { 'current_user' => create(:user) } }

      it { assert subject.failure? }
    end

    context 'zero balance' do
      let(:user_balance) { 0 }

      it { assert subject.failure? }
    end

    context 'same balance' do
      let(:user_balance) { pack_cost }

      it { assert subject.success? }
    end
  end
end
