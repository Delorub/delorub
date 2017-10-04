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

    context 'no pay type selected' do
      let(:pay_type) { nil }

      it { assert subject.failure? }
      it_behaves_like 'not creates new yandex deposit'
      it_behaves_like 'not create new billing log'
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
      it_behaves_like 'not creates new yandex deposit'
      it_behaves_like 'not create new billing log'
      it_behaves_like 'not to change user balance'
    end

    context 'paying from different types' do
      context 'visa' do
        let(:pay_type) { 'visa' }
        it { assert subject.success? }
        it_behaves_like 'not to change user balance'
        it_behaves_like 'create new yandex deposit'
        it_behaves_like 'create new billing log'
      end

      context 'qiwi' do
        let(:pay_type) { 'qiwi' }
        it { assert subject.success? }
        it_behaves_like 'not to change user balance'
        it_behaves_like 'create new yandex deposit'
        it_behaves_like 'create new billing log'
      end

      context 'webmoney' do
        let(:pay_type) { 'webmoney' }
        it { assert subject.success? }
        it_behaves_like 'not to change user balance'
        it_behaves_like 'create new yandex deposit'
        it_behaves_like 'create new billing log'
      end

      context 'yandex' do
        let(:pay_type) { 'yandex' }
        it { assert subject.success? }
        it_behaves_like 'not to change user balance'
        it_behaves_like 'create new yandex deposit'
        it_behaves_like 'create new billing log'
      end
    end
  end
end
