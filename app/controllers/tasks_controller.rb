class TasksController < ApplicationController
  include Pundit
  inherit_resources

  before_action :category_present?, only: [:index, :new]
  before_action :place_present?, only: [:index]
  before_action :place_settings, only: [:index]
  helper_method :all_categories

  decorates_assigned :tasks, :task

  def new
    authorize Task
    run Task::Operation::Create::Present, category: @category
  end

  def create
    authorize Task
    run Task::Operation::Create, task_params do |result|
      sign_in result['sign_in_new_user'] if result['sign_in_new_user']
      return redirect_to task_path(result['model']), notice: 'Задание добавлено'
    end

    render 'new'
  end

  def edit
    authorize resource
    run Task::Operation::Update::Present, id: resource.id
    p @form.to_nested_hash
  end

  def update
    authorize resource

    run Task::Operation::Update, task_params.merge(id: resource.id) do |result|
      return redirect_to task_path(result['model']), notice: 'Задание отредактировано'
    end

    render 'edit'
  end

  def destroy
    authorize resource
    resource.destroy
    redirect_to my_index_index_path, notice: 'Задание удалено'
  end

  private

    def end_of_association_chain
      TaskQuery.new(collection: super, scope: @scope, category: @category, current_user: current_user,
                    page: params[:page], order_direction: params[:order], place: @place).perform
    end

    def fetch_scope
      @scope = :all
      @scope = params[:scope].to_sym if params[:scope]
      not_found unless @scope.in? [:all, :my, :suggested]
    end

    def current_url category:
      params = {}
      params[:category_id] = category if category
      if @scope == :my
        my_tasks_path(params)
      elsif @scope == :suggested
        suggested_tasks_path(params)
      else
        category_tasks_path(params)
      end
    end

    def category_present?
      return unless params[:category_id]
      @category = Category.friendly.where(slug: params[:category_id]).first
      not_found if @category.blank?
    end

    def place_present?
      return unless params[:city_code]
      @place = Place.only_cities.friendly.find(params[:city_code])
    end

    def place_settings
      return unless @place && @category
      @place_settings = @place.categories_settings.with_settings_type(:task).where(category_id: @category.id).first
    end

    def all_categories
      @all_categories = Category.roots.includes(:children).except(:order).order(:position)
    end

    def task_params
      params.require(:task).permit!
    end
end
