class Admin::UsersController < Admin::BaseController
  before_action :logged_in_user, :admin_user, only: [:index, :edit, :destroy]


  def index
   @users = User.includes(:tasks)
  end

  def edit
    @users = User.includes(:tasks)
    @user = @current_user
  end

  def destroy 
    @user = User.find_by(id: params[:id])
    if User.find_admin > 1 && @user.admin? || !@user.admin?
      @user.destroy
      flash[:notice] = "使用者已刪除"
    else
      flash[:notice] = "管理者剩一位，無法再刪除！"
    end 
    
    redirect_to admin_users_path(@users)
  end
end
