class TaskController < ApplicationController
  helper_method :create_task_props

  def new
    @task = Task.new
    @form = CreateTaskForm.new @task
  end

  private

    def create_task_props
      {
        task: Entities::CreateTaskForm.represent(@form),
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
