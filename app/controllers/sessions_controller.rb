class SessionsController < ApplicationController
  def new
    @errors = flash[:errors]
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      set_session_variables(@user)
      redirect_to user_wins_path(@user), notice: "Hello, #{@user[:username].capitalize}!"
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

  private

  def set_session_variables(user)
    wins = user.wins
    
    if wins.empty?
      session[:earliest_win_date] = Date.today
      session[:latest_win_date] = Date.today
    else
      sorted_wins = wins.order(accomplished_date: :asc)
      session[:earliest_win_date] = sorted_wins.first.accomplished_date
      session[:latest_win_date] = sorted_wins.last.accomplished_date
    end

    session[:user_id] = user.id
    session[:username] = user.username.capitalize
    session[:password_length] = params[:password].length
    session[:date_start] = session[:earliest_win_date]
    session[:date_end] = session[:latest_win_date]
  end
end