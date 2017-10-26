class Admin::ExternalDataPolicy < AdminPolicy
  def approve?
    granted?
  end

  def reject?
    granted?
  end

  private

    def granted?
      super || user.permission.admin?
    end
end
