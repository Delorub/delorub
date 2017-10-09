ActiveAdmin.register User::BillingLog, namespace: :admin do
  config.batch_actions = false
  actions :index, :show

  filter :user_id, as: :ransack_filter, url: '/admin/users', display_name: 'name'
  filter :billable_type
  filter :created_at

  index do
    column :billable
    column :sum do |log|
      span class: (log.sum.negative? ? 'red' : 'green') do
        "#{log.sum} руб."
      end
    end
    column :state do |log|
      span class: "status_tag #{billing_log_state_class(log.state)}" do
        User::BillingLog.human_attribute_name(log.state)
      end
    end
    column :user
    column :created_at
    actions
  end
end
