describe Billing::TransferManually do
  let(:billing) { build :billing_transfer_manually }
  let(:user) { billing.user }
  subject { billing }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe '#save' do
    subject { billing.save }

    context 'transfer valid amount' do
      it { is_expected.to be true }
      it { expect{ subject }.to change(user, :balance).by(billing.amount) }
    end

    context 'transfer invalid amount' do
      before { billing.amount = -10.0 }

      it { is_expected.to be false }
      it { expect{ subject }.not_to change(user, :balance) }
    end
  end
end