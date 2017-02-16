module ActiveAdminShared::UserPermission
  extend ActiveSupport::Concern

  def self.included dsl
    dsl.send :sidebar, 'Права доступа', only: :show, if: proc{ authorized? :permission, user } do
      render partial: 'permission_sidebar', locals: { user: user }
    end

    dsl.send :member_action, :permission, method: [:get, :put] do
      @permission_resource = resource.permission || resource.build_permission

      if active_admin_namespace.name == :admin
        @permission_resource = ActiveAdmin::UserPermission::AdminDecorator.decorate(@permission_resource)
      else
        @permission_resource = ActiveAdmin::UserPermission::EditorDecorator.decorate(@permission_resource)
      end

      if request.put?
        @permission_resource.attributes = params[:user_permission].permit(@permission_resource.permissions_list)
        if @permission_resource.save
          redirect_to resource_path, notice: 'Права доступа успешно обновлены'
        end
      end
    end
  end
end
