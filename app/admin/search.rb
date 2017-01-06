ActiveAdmin.register_page "Search" do
  menu false

  content do
    panel "Результаты поиска" do
      AdminSearcher.new params[:q]
    end
  end
end