describe User do
  let(:user) { build :user }
  subject { user }

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe 'phone' do
    context 'when phone number not entered' do
      let!(:another_user) { create :user }
      before do
        user.phone = nil
        user.phone_confirmed = false
      end

      it { is_expected.to be_valid }
    end

    context 'when someone confirmed same phone number' do
      let!(:another_user) { create :user }
      before do
        user.phone = another_user.phone
        user.phone_confirmed = false
      end

      it { is_expected.not_to be_valid }
    end

    context 'when someone have same unconfirmed phone number' do
      let!(:another_user) { create :user, phone_confirmed: false }
      before do
        user.phone = another_user.phone
        user.phone_confirmed = false
      end

      it { is_expected.to be_valid }
    end

    context 'when someone confirmed same phone number in different format' do
      let!(:another_user) { create :user, phone: '+7 999 123 33 22', phone_confirmed: true }
      before do
        user.phone = '7(999)1233322'
        user.phone_confirmed = false
      end

      it { is_expected.not_to be_valid }
    end
  end
end
