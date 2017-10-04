shared_examples 'not create new billing log' do
  specify { expect { subject }.not_to(change { User::BillingLog.count }) }
end

shared_examples 'create new billing log' do
  specify { expect { subject }.to(change { User::BillingLog.count }) }
end
