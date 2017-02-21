shared_examples 'page not found response' do
  subject { response.status }

  it { is_expected.to eq 404 }
end
