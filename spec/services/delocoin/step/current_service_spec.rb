describe Delocoin::Step::CurrentService do
  let(:instance) { described_class.new }

  describe '#perform' do
    subject { instance.perform }

    let!(:step) { create :delocoin_step, date_from: Time.zone.now }

    before { Timecop.freeze }
    after { Timecop.return }

    context 'one step' do
      it { is_expected.to eq step }
    end

    context 'many steps ahead' do
      before do
        create :delocoin_step, date_from: Time.zone.now - 1.year
        create :delocoin_step, date_from: Time.zone.now + 1.year
        create :delocoin_step, date_from: Time.zone.now + 1.day
      end

      it { is_expected.to eq step }
    end

    context 'step changed' do
      let!(:previous_step) { create :delocoin_step, date_from: Time.zone.now - 1.day }

      before do
        step.date_from = Time.zone.now + 1.day
        step.save
      end

      it { is_expected.to eq previous_step.reload }
    end
  end
end
