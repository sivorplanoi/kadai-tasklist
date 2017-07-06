class UsersController < ApplicationController
  before_action :require_user_logged_in, only: :show

  def show
    @user = User.find_by(id: params[:id])
    @tasks = current_user.tasks.order('created_at').page(params[:page]).per(10)
    counts(@user)
    
    if (current_user != @user) || (@user==nil)
      redirect_to '/'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user =User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
    
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
