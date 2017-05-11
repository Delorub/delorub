class TaskController < ApplicationController
  helper_method :task_form_props

  def index
  end

  def new
    @form = TaskForm.new Task.new
    @form.user_id = current_user.id
  end

  def create
    @form = TaskForm.new Task.new
    @form.user_id = current_user.id

    if @form.validate task_params
      return redirect_to task_path(@form.model) if @form.save
    end

    render 'new'
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :main_category_id, :category_id, :price_type, :price_exact,
        :price_from, :price_to, :date_type, :date_actual_date, :date_actual_time, :contract_type, :paid_functions,
        :notifications_type, :place_id, :place_address
      )
    end

    def task_form_props
      {
        form_action: task_index_path,
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
