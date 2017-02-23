describe SmsConfirmation do
  let(:sms_confirmation) { build :sms_confirmation }
  subject { sms_confirmation }

  before do
    allow_any_instance_of(SmsSender).to receive(:perform).and_return(true)
  end

  describe 'validations' do
    it { is_expected.to be_valid }
  end

  describe '#save' do
    subject { sms_confirmation.save }

    it { is_expected.to be true }
    it { expect{ subject }.to change(described_class, :count).by(1) }
  end

  describe '#resend_code' do
    subject { sms_confirmation.resend_code }

    it { is_expected.to be true }
    it { expect{ subject }.to change(sms_confirmation, :last_sent_at) }
  end

  describe '#check_code' do
    let(:sms_confirmation) { create :sms_confirmation }
    subject { sms_confirmation.check_code code }

    context 'when trying to pass valid code' do
      let(:code) { sms_confirmation.code }

      it { is_expected.to be true }
    end

    context 'when trying to pass invalid code' do
      let(:code) { 'error' }

      it { is_expected.to be false }
      it { expect{ subject }.to change(sms_confirmation, :attempts).by(1) }
    end
  end

  describe '#token' do
    let(:sms_confirmation) { create :sms_confirmation }

    subject { sms_confirmation.token }

    it { is_expected.to match(/\A[0-9a-f]{32,128}\z/i) }
  end
end
