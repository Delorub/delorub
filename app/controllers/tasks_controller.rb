class TasksController < ApplicationController
  include Pundit
  inherit_resources
  decorates_assigned :tasks

  before_action :category_present?, only: [:index]
  before_action :all_categories, only: [:index]
  before_action :task_present?, only: [:show]

  helper_method :task_form_props, :current_url

  def show
    return redirect_to deal_path(resource.deal) if resource.deal.present? && policy(resource.deal).show?
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
      TaskQuery.new(collection: super, scope: @scope, category: @category,
                    current_user: current_user, page: params[:page], param_order: params[:order]).perform
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

    def task_present?
      @task = Task.where(id: params[:id]).first
      render_page_not_found if @task.blank?
    end

    def category_present?
      return unless params[:category_id]
      category = Category.friendly.where(slug: params[:category_id]).first
      render_page_not_found if category.blank?
      @category = category.decorate
    end

    def all_categories
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
