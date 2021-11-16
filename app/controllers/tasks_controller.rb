class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]
  
  def index 
    @tasks = Task.all
  end

  def new 
    @task = Task.new
  end

  def edit 
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "任務新增成功"
      redirect_to tasks_path 
    else 
      render :new
    end  
  end

  def update
    if @task.update(task_params)
      flash[:notice] = "任務更新成功"
      redirect_to tasks_path 
    else
      render :edit
    end
  end

  def destroy 
    @task.destroy if @task
    flash[:notice] = "任務已刪除"
    redirect_to tasks_path 
  end

  private 

  def task_params
    params.require(:task).permit(:title, :start, :end, :content)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end
end
