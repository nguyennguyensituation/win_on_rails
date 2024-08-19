# frozen_string_literal: true

# The Users controller contains all CRUD methods for User objects
class UsersController < ApplicationController
  include SessionMethods
  before_action :authorized, only: [:show]
  before_action :set_user, only: %i[my_account destroy]

  def show
    redirect_to user_wins_path(session[:user_id])
  end

  def new
    @user = User.new
    @errors = flash[:errors]
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save
      default_session_variables(@user)
      session[:password_length] = user_params[:password].length
      redirect_to @user, notice: "Welcome, #{session[:username]}!"
    else
      session[:username_entered] = user_params[:username]
      flash[:errors] = @user.errors.full_messages
      redirect_to create_account_path
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def destroy
    @user.destroy
    reset_session
    redirect_to home_path, notice: 'Your account has been deleted.'
  end

  def my_account
    wins = @user.wins
    @categories = {}
    @total = wins.length

    wins.each do |win|
      category = win.category

      @categories[category] = @categories[category] ? @categories[category] + 1 : 1
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
