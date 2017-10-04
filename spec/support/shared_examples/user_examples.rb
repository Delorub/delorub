shared_examples 'not to change user balance' do
  specify { expect { subject }.not_to(change { user.reload.balance }) }
end

shared_examples 'change user balance' do
  specify { expect { subject }.to(change { user.reload.balance }.by(amount)) }
end
