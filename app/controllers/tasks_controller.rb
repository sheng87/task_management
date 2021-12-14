class TasksController < ApplicationController
  before_action :log_in_before_task, except: [:home]
  before_action :find_task, only: [:edit, :update, :destroy]
  before_action :current_user, only: [:index, :create]

  def home
  end

  def index
      # ransack 搜尋
      @q = @current_user.tasks.ransack(params[:q])
      @tasks = @q.result(distinct: true)
      @tasks = @tasks.page(params[:page]).per(10)

       # 排序
      unless  params[:q]
        @tasks = @tasks.order(:title)
      end
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = @current_user.tasks.create(task_params)
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
    current_user
    @task = @current_user.tasks.find_by(id: params[:id])
  end

  def log_in_before_task
    unless logged_in?
      redirect_to login_path
      flash[:notice] = "請先登入"
    end
  end
end
