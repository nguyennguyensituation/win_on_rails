class WinsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @wins = @user.wins.sort_by { |win| win.accomplished_date }
  end

  def show
    @user = User.find(params[:user_id])
    @win = @user.wins.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @errors = flash[:errors]
  end

  def create
    @user = User.find(params[:user_id])
    @win = @user.wins.build(win_params)
    
    if @win.valid?
      @win.save
      reset_form
      redirect_to user_wins_path(@user), notice: "#{@win[:title]} added!"
    else
      set_form_values
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
      redirect_to user_win_path, notice: "#{@win.title} has been updated."
    else
      flash[:errors] = new_win.errors.full_messages
      redirect_to edit_user_win_path
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @win = @user.wins.find(params[:id])
    @win.destroy
    redirect_to @user, notice: "#{@win.title} has been deleted."
  end

  private
  FIELDS = ['title', 'description', 'category', 'accomplished_date(1i)', 'accomplished_date(2i)', 'accomplished_date(3i)']

  def set_form_values
    FIELDS.each { |field| session[field] = win_params[field] }
  end

  def reset_form
    FIELDS.each { |category| session[category] = nil } 
  end

  def win_params
    params.require(:win).permit(:title, :description, :category, :accomplished_date)
  end
end
