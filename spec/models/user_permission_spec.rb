describe UserPermission do
  let(:user_permission) { build :user_permission }
  subject { user_permission }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:user) }
  end

  describe '#set' do
    subject { user_permission.superadmin = true }

    it do
      expect { subject }.to change { user_permission.superadmin }.from(false).to(true)
    end
  end

  describe '#get' do
    subject { user_permission.superadmin? }
    it { is_expected.to eq false }
  end

  describe '#save' do
    subject { user_permission.save }

    context 'when permissions are empty' do
      it do
        expect(user_permission).to receive :destroy
        subject
      end
    end

    context 'when permissions are not empty' do
      before { user_permission.superadmin = true }

      it { is_expected.to eq true }
      it { expect{ subject }.to change(described_class, :count).by(1) }

      it do
        subject
        expect(user_permission.superadmin).to eq true
      end
    end
  end
end
