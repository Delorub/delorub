shared_examples_for 'success response' do
  subject { dispatch }

  it { is_expected.to be_success }
end
