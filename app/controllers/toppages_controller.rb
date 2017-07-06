class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      redirect_to user_url(id: session[:user_id])
    else
    end
  end
  
end
