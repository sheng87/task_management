class UsersController < ApplicationController
  before_action :logged_in_user, :correct_user, :find_user, only: [:edit, :update]

  def new 
    @user = User.new
  end

  def edit
    if params[:choose] == "管理員"
      admin_user
      redirect_to edit_admin_user_path(@user)
    end   
  end

  

  def create 
    @user = User.create(user_params)
    
    if @user.save 
      log_in @user
      redirect_to tasks_path(@user.tasks)
      flash.now[:notice] = "Welcome to the Task Management App!"
    elsif ActiveRecord::RecordNotUnique
      @user = User.find_by(email: params[:email])
      redirect_to login_path
      flash[:notice] = "已註冊過會員請登入"
    else 
      render 'new'
    end

  end

  def update 
    if @user.update(user_params)  
      redirect_to tasks_path(@user.tasks)
    else
      render 'edit'
      flash.now[:notice] = "更新失敗"
    end
  end

  

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
     @user = User.friendly.find(params[:id])
  end

  

  def correct_user 
    @user = User.friendly.find(params[:id])
    redirect_to root_path unless @user == current_user
  end

  
end
