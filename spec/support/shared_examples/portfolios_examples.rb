shared_examples 'create new portfolio' do
  specify { expect { subject }.to(change { Portfolio.count }) }
end

shared_examples 'not create new portfolio' do
  specify do
    subject {}
    expect { subject }.not_to(change { Portfolio.count })
  end
end
