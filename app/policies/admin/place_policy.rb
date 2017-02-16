class Admin::PlacePolicy < AdminPolicy
  private

    def granted?
      super || user.permission.admin_place?
    end
end
