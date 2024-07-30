class UsersController < ApplicationController
  before_action :authorized, only: [:show]
  
  def show
    redirect_to user_wins_path(session[:user_id])
  end

  def new
    @user = User.new
    @errors = flash[:errors]
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      session[:password_length] = user_params[:password].length
      redirect_to @user, notice: "Welcome, #{@user[:username].capitalize}!"
    else  
      session[:username_entered] = user_params[:username]
      flash[:errors] = @user.errors.full_messages
      redirect_to create_account_path
    end
  end

  def my_account
    @user = User.find(session[:user_id])
  end

  def destroy
    @user = User.find(session[:user_id])
    @user.destroy
    reset_session
    redirect_to home_path, notice: "Your account has been deleted."
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
