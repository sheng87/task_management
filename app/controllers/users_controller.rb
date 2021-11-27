class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]


  def new 
    @user = User.new
  end

  def create 
    @user = User.create(user_params)
    
    if @user.save 
      log_in @user
      redirect_to @user
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

  def destroy 
    @user.destroy
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
     @user = User.find(params[:id])
  end
end
