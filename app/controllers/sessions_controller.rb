class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:password_length] = params[:password].length
      redirect_to @user
    else  
      session[:username_entered] = params[:username]
      redirect_to sign_in_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end