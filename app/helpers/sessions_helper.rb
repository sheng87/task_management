module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
  
  def logged_in_user
    unless logged_in?
      flash[:notice] = "請先登入"
      redirect_to login_path
    end
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user) 
    user == current_user
  end

  def admin_user
    unless current_user.admin?
      flash[:notice] = "權限不足無法存取"
      redirect_to tasks_path(@current_user.tasks)   
    end  
  end
end
