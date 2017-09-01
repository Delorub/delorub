class My::IndexController < My::ApplicationController
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
      render 'user'
    end
end
