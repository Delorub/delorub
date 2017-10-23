ActiveAdmin.register Billing::ManualTransfer, namespace: :admin do
  menu false
  include ActiveAdminShared::BillingManualTransfer
end
