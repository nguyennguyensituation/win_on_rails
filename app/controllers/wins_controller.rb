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

  def edit
    @user = User.find(params[:user_id])
    @win = @user.wins.find(params[:id])
    @errors = flash[:errors]
  end

  def update
    @user = User.find(params[:user_id])
    @win = @user.wins.find(params[:id])
    new_win = @user.wins.build(win_params)

    if new_win.valid?
      @win.update(win_params)
      redirect_to user_win_path, notice: "#{@win.title} updated!"
    else
      flash[:errors] = new_win.errors.full_messages
      redirect_to edit_user_win_path
    end

  end

  def index
    @user = User.find(params[:user_id])
    @wins = @user.wins.sort_by { |win| win.accomplished_date }
  end

  def show
    @user = User.find(params[:user_id])
    @win = @user.wins.find(params[:id])

  end

  private

  def win_params
    params.require(:win).permit(:title, :description, :category, :accomplished_date)
  end
end
