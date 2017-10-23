module ActiveAdminShared::BillingManualTransfer
  extend ActiveSupport::Concern

  def self.included dsl
    confirm_manual_transfer dsl
  end

  class << self
    def confirm_manual_transfer dsl
      dsl.send :member_action, :confirm_manual_transfer, method: [:get, :put] do
        if request.put?
          run Billing::ManualTransfer::Operation::Finish, id: resource.id do |result|
            return redirect_to admin_user_path(resource.user), notice: 'Сумма успешно зачислена на счет'
          end
        end
      end
    end
  end
end
