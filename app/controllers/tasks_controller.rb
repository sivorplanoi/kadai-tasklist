class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  
  def new
    @task = current_user.tasks.build  # form_for 用
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save 
      flash[:success] = @count_tasks.to_s + 'タスクが正常に追加されました'
      redirect_to user_url(id: session[:user_id])
    else
      flash.now[:danger] = 'タスクが追加されませんでした'
      render :new
    end
  end

  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to user_url(id: session[:user_id])
    else
      flash[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    @user = current_user
    redirect_to user_url(id: session[:user_id])
  end
  
  private
  
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to root_url unless @task
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
    
  end
  
end
