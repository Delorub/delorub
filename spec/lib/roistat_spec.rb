describe Roistat do
  include ActiveJob::TestHelper

  let(:user) { create :user }
  let(:cookie_visit) { rand(1000..9999) }
  let(:method) { :user_registration }
  let(:instance) { described_class.new(user, cookie_visit) }
  let(:payload) { {cost: rand(1000..9999)} }

  let(:params) do
    {
      'roistat' => cookie_visit,
      'key'     => Figaro.env.roistat_apy_key,
      'name'    => user.decorate.name,
      'email'   => user.email,
      'phone'   => user.phone,
      'sync'    => '1'
    }
  end
  let(:send_params) { params.merge(instance.user_registration).to_query }

  before do
    stub_request(:get, "#{Figaro.env.roistat_url}#{send_params}")
      .to_return(status: 200)
  end

  describe 'create worker after call roistat' do
    subject { instance.push_async(method) }
    let(:payload) { nil }

    it do
      expect { subject }.to change(RoistatWorker.jobs, :size).by(1)
      expect(RoistatWorker).to have_enqueued_sidekiq_job(method, user.id, cookie_visit, payload)
    end
  end

  describe 'roistat push #user_registration' do
    it { expect(instance.push(method, payload)) }
  end

  describe 'roistat push #delocoin_buy_create' do
    let(:method) { :delocoin_buy_create }
    let(:send_params) { params.merge(instance.delocoin_buy_create(payload)).to_query }

    it { expect(instance.push(method, payload)) }
  end

  describe 'roistat push #delocoin_buy_finish' do
    let(:method) { :delocoin_buy_finish }
    let(:send_params) { params.merge(instance.delocoin_buy_finish(payload)).to_query }

    it { expect(instance.push(method, payload)) }
  end
end
