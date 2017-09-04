class Admin::CityPolicy < AdminPolicy
  def change_settings?
    update?
  end

  private

  def granted?
    super || user.permission.admin_city?
  end
end
