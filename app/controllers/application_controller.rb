class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user, 

  def root
    redirect_to logged_in? ? user_path(session[:user_id]) : home_path
  end

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    redirect_to sign_in_path unless logged_in?
  end
end
