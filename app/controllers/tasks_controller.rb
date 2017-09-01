class TasksController < ApplicationController
  include Pundit
  inherit_resources

  before_action :category_present?, only: [:index, :new]
  helper_method :all_categories

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

    def all_categories
      @all_categories = Category.roots.includes(:children).order(:position)
    end

    def task_params
      params.require(:task).permit!
    end
end
