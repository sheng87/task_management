class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy]
  
  def home
  end

  def index 
    if current_user
    @q = @current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true)
    @tasks = @tasks.page(params[:page]).per(10)

      unless params[:sort] || params[:q]
        @tasks = @current_user.tasks.order(:title).page(params[:page]).per(10)
      end

      case
        when params[:sort] && params[:sort] == "以結束時間"
          @tasks = @current_user.tasks.ordered_by_endtime.page(params[:page]).per(10)  
        when params[:sort] && params[:sort] == "以建立時間"   
          @tasks = @current_user.tasks.ordered_by_created_at.page(params[:page]).per(10)  
        when params[:sort] && params[:sort] == "以優先順序"   
          @tasks = @current_user.tasks.ordered_by_priority.page(params[:page]).per(10)  
      end
    end
  end

  def new 
    @task = Task.new
  end

  def edit 
  end

  def create
    @task = Task.new(task_params)
    if logged_in? && @task.save
      flash.now[:notice] = t(:create_flash)
      redirect_to tasks_path 
    else 
      flash.now[:notice] = "請先登入"
      render 'new'
    end  
  end

  def update
    if @task.update(task_params)
      flash.now[:notice] = t(:update_flash)
      redirect_to tasks_path 
    else
      render :edit
    end
  end

  def destroy 
    @task.destroy if @task
    flash.now[:notice] = t(:delete_flash)
    redirect_to tasks_path 
  end

  private 

  def task_params
    params.require(:task).permit(:title, :start, :end, :content, :status, :priority)
  end

  def find_task
    @task = Task.find_by(id: params[:id])
  end
end
