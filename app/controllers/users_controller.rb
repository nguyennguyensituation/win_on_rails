class UsersController < ApplicationController
  def new
    @article = User.new
  end

  def create
    @user = User.new(user_params)


  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :password_check)
    end
end
