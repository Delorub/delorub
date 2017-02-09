module ActiveAdminShared::User
  extend ActiveSupport::Concern

  def self.included dsl
    dsl.send :filter, :email
    dsl.send :filter, :first_name
    dsl.send :filter, :last_name
    dsl.send :filter, :phone

    dsl.send :show do
      render 'user_show'
    end
    
    dsl.send :sidebar, 'Изображение', only: :show, if: proc{ !user.photo.file.nil? } do
      img src: user.photo.thumb.url
    end
  end
end
