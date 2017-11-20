describe Portfolio::Operation::Create do
  let(:instance) { described_class }
  let(:user) { create :user }
  let(:profile) { create :profile, user: user }
  let(:portfolio_item) { create :portfolio_item }

  describe '#call' do
    let(:name) { 'test name' }
    let(:description) { 'test description' }
    let(:portfolio_items_params) { [{ id: portfolio_item.id, description: 'item description' }] }
    let(:profile_id) { profile.id }

    let(:params) do
      { name: name, description: description, profile_id: profile_id, portfolio_items: portfolio_items_params }.as_json
    end
    let(:options) { { 'current_user' => user } }

    subject { described_class.call(params, options) }

    context 'create portfolio when have not profile' do
      let(:profile_id) { nil }

      it { assert subject.failure? }
      it_should_behave_like 'not create new portfolio'
    end

    context 'create portfolio without name' do
      let(:name) { nil }

      it { assert subject.failure? }
      it_behaves_like 'not create new portfolio'
    end

    context 'create portfolio without portfolio_items' do
      let(:portfolio_items_params) { nil }

      it { assert subject.failure? }
      it_behaves_like 'not create new portfolio'
    end

    context 'success create portfolio' do
      it { assert subject.success? }
      it_behaves_like 'create new portfolio'
    end
  end
end
