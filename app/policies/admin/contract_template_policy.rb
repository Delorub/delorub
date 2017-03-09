class Admin::ContractTemplatePolicy < AdminPolicy
  private

    def granted?
      super || user.permission.admin_contract_template?
    end
end
