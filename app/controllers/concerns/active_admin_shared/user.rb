module ActiveAdminShared::User
  extend ActiveSupport::Concern

  def self.included dsl
    dsl.send :filter, :by_search_in, label: 'Поиск', as: :string
    dsl.send :filter, :created_at

    dsl.send :show do
      render 'user_show'
    end

    dsl.send :sidebar, 'Изображение', only: :show, if: proc{ !user.photo.file.nil? } do
      img src: user.photo.small.url
    end
    authorize_by_user dsl
  end

  class << self
    def authorize_by_user dsl
      dsl.send :member_action, :login_as, method: :get do
        user = User.find(params[:id])
        sign_in(user, bypass: true)
        redirect_to my_index_index_path
      end
    end
  end
end
