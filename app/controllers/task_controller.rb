class TaskController < ApplicationController
  helper_method :create_task_props

  def new
    @task = CreateTaskForm.new Task.new
  end

  private

    def create_task_props
      {
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
