class My::SettingsController < My::ApplicationController
  def edit
    if signed_in_as_master?
      edit_master
    else
      edit_user
    end
  end

  def update
    if signed_in_as_master?
      update_master
    else
      update_user
    end
  end

  private

    def edit_master
      run User::Operation::Settings::Present

      render 'edit_master'
    end

    def update_master
      run User::Operation::Settings, user_params do |result|
        return redirect_to edit_my_settings_path, notice: 'Настройки отредактированы'
      end

      render 'edit_master'
    end

    def edit_user
      run User::Operation::Settings::Present

      render 'edit_user'
    end

    def update_user
      run User::Operation::Settings, user_params do |result|
        return redirect_to edit_my_settings_path, notice: 'Настройки отредактированы'
      end

      render 'edit_user'
    end

    def user_params
      params.require(:user).permit!
    end
end
