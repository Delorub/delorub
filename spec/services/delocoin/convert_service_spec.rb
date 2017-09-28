describe Delocoin::ConvertService do
  let(:instance) { described_class.new }
  let(:step) { create :delocoin_step, rate: 1.0 }
  let(:pack) { create :delocoin_pack, discount: 1.0 }

  describe '#balance_to_delocoins' do
    let(:balance) { 500 }

    subject { instance.balance_to_delocoins(step: step, pack: pack, balance: balance) }

    it { is_expected.to eq 500 }

    context 'step rate' do
      let(:step) { create :delocoin_step, rate: 500.0 }

      it { is_expected.to eq 1 }
    end

    context 'pack discount' do
      let(:pack) { create :delocoin_pack, discount: 0.5 }

      it { is_expected.to eq 1000 }
    end

    context 'big numbers' do
      let(:balance) { 1_000_000 }
      let(:step) { create :delocoin_step, rate: 2 }
      let(:pack) { create :delocoin_pack, discount: 0.5 }

      it { is_expected.to eq 1_000_000 }
    end

    context 'small numbers' do
      let(:balance) { 5 }
      let(:step) { create :delocoin_step, rate: 4 }
      let(:pack) { create :delocoin_pack, discount: 0.5 }

      it { is_expected.to eq 2.5 }
    end
  end

  describe '#delocoins_to_balance' do
    let(:delocoins) { 500 }

    subject { instance.delocoins_to_balance(step: step, pack: pack, delocoins: delocoins) }

    it { is_expected.to eq 500 }

    context 'step rate' do
      let(:step) { create :delocoin_step, rate: 500.0 }

      it { is_expected.to eq 250_000 }
    end

    context 'no pack' do
      let(:pack) { nil }

      it { is_expected.to eq 500 }
    end

    context 'pack discount' do
      let(:pack) { create :delocoin_pack, discount: 0.5 }

      it { is_expected.to eq 250 }
    end
  end
end
