class TasksController < ApplicationController
  include Pundit
  inherit_resources

  before_action :category_present?, only: [:index, :new]
  before_action :city_present?, only: [:index]
  before_action :city_settings, only: [:index]
  helper_method :all_categories, :active_cities

  decorates_assigned :tasks, :task

  def new
    authorize Task
    run Task::Operation::Present, category: @category
  end

  def create
    authorize Task
    run Task::Operation, task_params do |result|
      sign_in result['sign_in_new_user'] if result['sign_in_new_user']
      return redirect_to task_path(result['model']), notice: 'Задание добавлено'
    end

    render 'new'
  end

  private

    def end_of_association_chain
      TaskQuery.new(collection: super, scope: @scope, category: @category,
                    current_user: current_user, page: params[:page], order_direction: params[:order]).perform
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

    def city_present?
      return if params[:city_code].blank?
      @city = City.where(code: params[:city_code]).first
      not_found if @city.blank?
    end

    def city_settings
      return unless @city && @category
      @city_settings = @city.city_categories.with_settings_type(:task).where(category_id: @category.id).first
    end

    def all_categories
      @all_categories = Category.roots.includes(:children).order(:position)
    end

    def active_cities
      @active_cities = City.active
    end

    def task_params
      params.require(:task).permit!
    end
end
