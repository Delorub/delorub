class Admin::ExternalDataPolicy < AdminPolicy
  private

    def granted?
      super || user.permission.admin?
    end
end
