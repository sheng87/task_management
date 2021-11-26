class SessionsController < ApplicationController
  def new
  end

  def create 
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to tasks_path(user.tasks)
    else
      # Create an error message.
      flash.now[:notice] = "密碼或Email信箱錯誤"
      render 'new'
    end
  end

  def destroy 
    log_out
    redirect_to root_path
  end
end
