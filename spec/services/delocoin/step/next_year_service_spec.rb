describe Delocoin::Step::NextYearService do
  let(:instance) { described_class.new }

  describe '#perform' do
    subject { instance.perform }

    let!(:step) { create :delocoin_step, date_from: Time.zone.now + 1.year - 1.day }

    before { Timecop.freeze }
    after { Timecop.return }

    context 'many steps ahead' do
      before do
        create :delocoin_step, date_from: Time.zone.now + 1.year + 1.day
        create :delocoin_step, date_from: Time.zone.now + 1.year - 2.days
        create :delocoin_step, date_from: Time.zone.now + 2.years
      end

      it { is_expected.to eq step }
    end

    context 'no steps ahead' do
      let!(:step) { create :delocoin_step, date_from: Time.zone.now }

      it { is_expected.to eq step }
    end

    context 'real example' do
      let!(:step) { create :delocoin_step, date_from: Date.parse('13-10-2018') }

      before { Timecop.freeze(Time.zone.local(2017, 10, 15, 10, 5, 3)) }

      before do
        create :delocoin_step, date_from: Date.parse('12-09-2018')
        create :delocoin_step, date_from: Date.parse('26-11-2018')
      end

      it { is_expected.to eq step }
    end
  end
end
