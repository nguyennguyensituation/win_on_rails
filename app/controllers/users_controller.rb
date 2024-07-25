class UsersController < ApplicationController
  before_action :authorized, only: [:show]
  
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      # automatically sign in after creating account
      session[:user_id] = @user.id
      session[:password_length] = user_params[:password].length
      redirect_to @user
    else  
      redirect :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def my_account
    @user = User.find(session[:user_id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
