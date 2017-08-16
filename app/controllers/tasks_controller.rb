class TasksController < ApplicationController
  include Pundit
  inherit_resources
  decorates_assigned :tasks

  before_action :category_present?, :only => [:index]
  before_action :get_categories,    :only => [:index]
  before_action :task_present?,     :only => [:show]

  #helper_method :task_form_props, :current_url

  def index
    tasks = @category.present? ? @category.tasks : Task.all
    @tasks = tasks.includes(:user)
                  .order(:created_at => (params[:order].present? and params[:order] == 'asc') ? 'asc' : 'desc')
                  .page(params[:page].to_i > 0 ? params[:page] : params[:page])
                  .per(4)
  end

  def show
    #return redirect_to deal_path(resource.deal) if resource.deal.present? && policy(resource.deal).show?
  end

  def new
    run Task::Operation::Present
  end

  def create
    run Task::Operation, task_params do |result|
      sign_in result['sign_in_new_user'] if result['sign_in_new_user']
      return redirect_to task_path(result['model']), notice: 'Задание добавлено'
    end

    render 'new'
  end

  def edit
    authorize resource, :edit?
    @form = TaskForm.new resource.decorate
  end

  def update
    authorize resource, :edit?
    @form = TaskForm.new resource.decorate

    if @form.validate task_params
      creator = Task::FormCreator.new(@form)
      creator.perform
      return redirect_to task_path(creator.model), notice: 'Задание отредактировано' if creator.model.persisted?
      flash.now.alert = creator.last_error
    else
      flash.now.alert = @form.errors
    end
  end

  private

    def end_of_association_chain
      TaskQuery.new(collection: super, scope: @scope, category: @category, current_user: current_user).perform
    end

    # TODO если данные две ф-ии не используются надо их удалить, видимо старое осталось
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
    # конец todo

    def task_present?
      @task = Task.find(params[:id]) rescue render_page_not_found
    end

    def category_present?
      @category = Category.friendly.find(params[:category_id]) rescue render_page_not_found if params[:category_id]
    end

    def get_categories
      @categories = Category.roots.includes(:children).order(:position)
    end

    def task_params
      params.require(:task).permit!
    end

    def form_from_session
      @form.validate create_data_after_authorization(:task) if create_after_authorization? :task
    end

    def store_form_to_session
      @form.save do |data|
        create_after_authorization :task, data
      end
    end
end
