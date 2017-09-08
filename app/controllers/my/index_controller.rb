class My::IndexController < My::ApplicationController
  decorates_assigned :tasks

  def index
    if signed_in_as_master?
      master
    else
      user
    end
  end

  private

    def master
      render 'master'
    end

    def user
      @tasks = current_user.tasks.page(params[:page].to_i.positive? ? params[:page] : 1).per(4)
      render 'user'
    end
end
