class My::PortfoliosController < My::ApplicationController
  inherit_resources

  def new
    authorize Portfolio

    run Portfolio::Operation::Create::Present
  end

  def create
    run Portfolio::Operation::Create, params[:portfolio].merge(profile: current_user.profile) do |result|
      return redirect_to my_index_index_path, notice: 'Портфолио успешно создано'
    end

    render 'new'
  end

  def edit
    authorize resource

    run Portfolio::Operation::Update::Present, id: resource.id
  end

  def update
    authorize resource

    run Portfolio::Operation::Update, params[:portfolio].merge(id: resource.id) do |result|
      return redirect_to my_index_index_path, notice: 'Портфолио успешно изменено'
    end

    render 'edit'
  end
end
