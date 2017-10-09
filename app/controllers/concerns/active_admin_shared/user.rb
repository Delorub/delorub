module ActiveAdminShared::User
  extend ActiveSupport::Concern

  def self.included dsl
    dsl.send :filter, :by_search_in, label: 'Поиск', as: :string

    dsl.send :show do
      render 'user_show'
    end

    dsl.send :sidebar, 'Изображение', only: :show, if: proc{ !user.photo.file.nil? } do
      img src: user.photo.small.url
    end
  end
end
