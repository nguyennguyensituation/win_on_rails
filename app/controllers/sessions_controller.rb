class SessionsController < ApplicationController
  def new
    @errors = flash[:errors]
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:password_length] = params[:password].length
      redirect_to @user, notice: "Hello, #{@user[:username].capitalize}!"
    else  
      session[:username_entered] = params[:username]
      flash[:errors] = ["Invalid username or password"]
      redirect_to sign_in_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "You are signed out!"
  end
end