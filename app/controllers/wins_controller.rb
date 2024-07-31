class WinsController < ApplicationController
  def index
    set_user
    @wins = @user.wins.sort_by { |win| win.accomplished_date }
  end

  def show
    set_user
    set_win
  end

  def new
    set_user
    @errors = flash[:errors]
  end

  def create
    set_user
    @win = @user.wins.build(win_params)
    
    if @win.valid?
      @win.save
      reset_session_form_values
      redirect_to user_wins_path(@user), notice: "#{@win[:title]} added!"
    else
      set_session_form_values
      flash[:errors] = @win.errors.full_messages
      redirect_to new_user_win_path
    end
  end

  def edit
    set_user
    set_win
    @errors = flash[:errors]
  end

  def update
    set_user
    set_win
    edited_win = @user.wins.build(win_params)

    if edited_win.valid?
      @win.update(win_params)
      reset_session_form_values
      redirect_to user_win_path, notice: "#{@win.title} has been updated."
    else
      set_session_form_values
      flash[:errors] = edited_win.errors.full_messages
      redirect_to edit_user_win_path
    end
  end

  def destroy
    set_user
    set_win
    @win.destroy
    redirect_to @user, notice: "#{@win.title} has been deleted."
  end

  def cancel
    @user = User.find(session[:user_id])
    reset_session_form_values
    redirect_to @user
  end

  private
  FIELDS = ['title', 'description', 'category', 'accomplished_date(1i)', 'accomplished_date(2i)', 'accomplished_date(3i)']

  def set_session_form_values
    FIELDS.each { |field| session[field] = win_params[field] }
  end

  def reset_session_form_values
    FIELDS.each { |field| session[field] = nil } 
  end

  def win_params
    params.require(:win).permit(:title, :description, :category, :accomplished_date)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_win
    @win = @user.wins.find(params[:id])
  end
end
