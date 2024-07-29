class WinsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @errors = flash[:errors]
  end

  def create
    @user = User.find(params[:user_id])
    @win = @user.wins.build(win_params)
    
    if @win.valid?
      @win.save
      redirect_to user_wins_path(@user), notice: "#{win_params[:title]} added!"
    else
      session[:title] = win_params[:title]
      session[:description] = win_params[:description]
      flash[:errors] = @win.errors.full_messages
      redirect_to new_user_win_path
    end
  end

  def index
    @user = User.find(params[:user_id])
    @wins = @user.wins
  end

  private

  def win_params
    params.require(:win).permit(:title, :description, :category, :accomplished_date)
  end
end
