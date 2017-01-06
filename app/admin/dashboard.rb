ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ 'Главная' }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      form class: 'quicksearch', action: admin_search_path do |f|
        f.input type: :text, name: 'q', placeholder: "Быстрый поиск"
        f.input type: :submit, value: "Найти"
      end
    end
  end
end
