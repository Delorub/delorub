class TasksController < ApplicationController
  inherit_resources

  helper_method :task_form_props, :current_url

  def index
    fetch_category
    fetch_scope
  end

  def new
    @form = TaskForm.new Task.new
    get_form_from_session
    @form.user_id = current_user.id if user_signed_in?
  end

  def create
    @form = TaskForm.new Task.new
    @form.user_id = current_user.id if user_signed_in?

    if @form.validate task_params
      unless user_signed_in?
        store_form_to_session
        return redirect_to new_user_registration_path
      end
      return redirect_to task_path(@form.model) if @form.save
    end

    render 'new'
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
        :notifications_type, :place_id, :place_address
      )
    end

    def current_url category:
      if category
        category_tasks_path(category_id: category)
      else
        tasks_path
      end
    end

    def get_form_from_session
      @form.validate session[form_session_key] if session[form_session_key]
    end

    def store_form_to_session
      @form.save do |data|
        session[form_session_key] = data
      end
    end

    def form_session_key
      :task_form_data
    end

    def task_form_props
      {
        form_action: tasks_path,
        task: Entities::TaskForm.represent(@form),
        categories: Category.all.map { |e|
          {
            id: e.id,
            title: e.title,
            parent_id: e.parent_id
          }
        }
      }
    end
end