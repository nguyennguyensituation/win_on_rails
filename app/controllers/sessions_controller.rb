class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:password_length] = params[:password].length
      session[:error] = nil
      flash[:notice] = "Hello, #{@user[:username].capitalize}!"
      redirect_to @user
    else  
      session[:errors_array] = ["Your username or password is incorrect."]
      session[:username_entered] = params[:username]
      redirect_to sign_in_path
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You are signed out!"
    redirect_to root_path
  end
end