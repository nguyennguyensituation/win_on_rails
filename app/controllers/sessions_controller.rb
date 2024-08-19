# frozen_string_literal: true

# The Sessions controller contains all CRUD methods for Session objects
class SessionsController < ApplicationController
  include SessionMethods

  def new
    @errors = flash[:errors]
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      default_session_variables(@user)
      session[:password_length] = params[:password].length
      redirect_to user_wins_path(@user), notice: "Hello, #{session[:username]}!"
    else
      session[:username_entered] = params[:username]
      flash[:errors] = ['Invalid username or password']
      redirect_to sign_in_path
    end
  end
  # rubocop:enable Metrics/AbcSize

  def destroy
    reset_session
    redirect_to root_path, notice: 'You are signed out!'
  end
end
