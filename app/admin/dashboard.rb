ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ 'Главная' }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span 'Добро пожаловать в админ панель! Скоро тут будет гораздо больше функций.'
      end
    end
  end
end
