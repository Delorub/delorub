class TasksController < ApplicationController
  include Pundit
  inherit_resources
  decorates_assigned :tasks

  helper_method :task_form_props, :current_url

  def index
    fetch_category
    fetch_scope
    super
  end

  def new
    @form = TaskForm.new Task.new(user: current_user)
    form_from_session
  end

  def create
    @form = TaskForm.new Task.new(user: current_user)

    if @form.validate task_params
      unless user_signed_in?
        store_form_to_session
        return redirect_to new_user_session_path, notice: 'Отлично! Для завершения нужно войти либо зарегистрироваться'
      end
      creator = Task::FormCreator.new(@form)
      creator.perform
      return redirect_to task_path(creator.model), notice: 'Задание добавлено' if creator.model.persisted?
      flash.now.alert = creator.last_error
    else
      flash.now.alert = @form.errors
    end

    render 'new'
  end

  def edit
    @form = TaskForm.new resource
  end

  def update
    @form = TaskForm.new resource

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

    def fetch_scope
      @scope = :all
      @scope = params[:scope].to_sym if params[:scope]
      not_found unless @scope.in? [:all, :my, :suggested]
    end

    def fetch_category
      @category = Category.friendly.find params[:category_id] if params[:category_id]
    end

    def task_params
      params.require(:task).permit(:title, :description, :main_category_id, :category_id, :price_type, :price_exact,
        :price_from, :price_to, :date_type, :date_actual_date, :date_actual_time, :contract_type, :paid_functions,
        :notifications_type, :place_id, :place_address, files: [:id])
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

    def form_from_session
      @form.validate create_data_after_authorization(:task) if create_after_authorization? :task
    end

    def store_form_to_session
      @form.save do |data|
        create_after_authorization :task, data
      end
    end

    def task_form_props
      {
        form_action: params[:id].nil? ? tasks_path : task_path(resource),
        task: Entities::TaskForm.represent(@form),
        categories: Entities::Category.represent(Category.all)
      }
    end
end
