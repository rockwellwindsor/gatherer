#
class TasksController < ApplicationController

  before_action :set_task, only: [:show, :update]
  
  # GET /task/:id
  def show
  end

  # PUT /task/:id
  def update
    completed = params[:task].delete(:completed)
    params[:task][:completed_at] = Time.current if completed
    if @task.update_attributes(params[:task].permit(:size))
      TaskMailer.task_completed_email(@task).deliver if completed
      redirect_to @task, notice: "'project was successfully updated.'"
    else
      render action: 'edit'
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
end
