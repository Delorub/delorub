describe Billing::Delocoin::Buy::Operation::Create do
  let(:instance) { described_class }

  let!(:pack) { create :delocoin_pack }
  let(:pack_id) { pack.id }
  let!(:step) { create :delocoin_step }
  let(:user) { create :user }

  describe '::Create' do
    let(:accept_terms) { '1' }
    let(:pay_type) { 'balance' }

    let(:params) { { pack_id: pack_id, pay_type: pay_type, accept_terms: accept_terms } }
    let(:options) { { 'current_user' => user } }

    subject { described_class.call(params, options) }

    context 'no pay type selected' do
      let(:pay_type) { nil }

      it { assert subject.failure? }
    end

    context 'no user specified' do
      let(:user) { nil }

      it { assert subject.failure? }
    end

    context 'paying from balance' do
      let(:pay_type) { 'balance' }

      context 'valid' do
        it { assert subject.success? }
      end

      context 'not accepting terms' do
        let(:accept_terms) { nil }

        it { assert subject.failure? }
      end

      context 'no pack selected' do
        let(:pack_id) { nil }

        it { assert subject.failure? }
      end
    end
  end
end
