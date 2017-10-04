class Admin::ExternalData::VkAccountPolicy < AdminPolicy
  private

    def granted?
      super || user.permission.admin?
    end
end
