class Admin::VacancyPolicy < AdminPolicy
  private

    def granted?
      super || user.permission.admin_vacancy?
    end
end
