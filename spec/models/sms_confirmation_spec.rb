# == Schema Information
#
# Table name: sms_confirmations
#
#  id           :integer          not null, primary key
#  token        :string
#  phone        :string
#  code         :string
#  accepted     :boolean          default(FALSE)
#  attempts     :integer          default(0)
#  last_sent_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

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
end
