# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user

  def root
    redirect_to logged_in? ? user_path(session[:user_id]) : home_path
  end

  def logged_in?
    !!session[:user_id]
  end

  def authorized
    redirect_to sign_in_path unless logged_in?
  end

  def set_user
    @user = User.find(session[:user_id])
  end
end
