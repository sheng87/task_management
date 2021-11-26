class UsersController < ApplicationController
  def index 
  end

  def show 
    @user = User.find(params[:id])
  end

  def new 
    @user = User.new
  end

  def create 
    @user = User.create(user_params)
    if @user.save 
      log_in @user
      flash[:notice] = "Welcome to the Task Management App!"
      redirect_to @user
    else
      render 'new'
    end

  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
