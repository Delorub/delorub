ActiveAdmin.register_page "Search", namespace: :admin do
  menu false

  content do
    panel "Результаты поиска" do
      render partial: 'admin/shared/searchbox', locals: { query: params[:q] }
      render partial: 'results', locals: { results: AdminSearch.new(query: params[:q]).all }
    end
  end
end
