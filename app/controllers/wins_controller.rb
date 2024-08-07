class WinsController < ApplicationController
  include Pagy::Backend

  before_action :set_user
  before_action :set_win, only: [:show, :edit, :update, :destroy]

  def index    
    limit = 8
    @pagy, @wins = pagy(@user.wins.order(accomplished_date: :asc, title: :asc), limit: limit)
  end

  def new
    @errors = flash[:errors]
  end

  def create
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
    @errors = flash[:errors]
    session[:current_win_id] = @win.id;
  end

  def update
    edited_win = @user.wins.build(win_params)

    if edited_win.valid?
      @win.update(win_params)
      reset_session_form_values
      reset_current_win_id
      redirect_to user_win_path, notice: "#{@win.title} has been updated."
    else
      set_session_form_values
      flash[:errors] = edited_win.errors.full_messages
      redirect_to edit_user_win_path
    end
  end

  def destroy
    @win.destroy
    redirect_to @user, notice: "#{@win.title} has been deleted."
  end

  def cancel
    reset_session_form_values
    @win = @user.wins.find(session[:current_win_id])
    reset_current_win_id
    redirect_to user_win_path({ user_id: @user.id, id: @win.id })
  end

  private
  
  FIELDS = ['title', 'description', 'category', 'accomplished_date(1i)', 'accomplished_date(2i)', 'accomplished_date(3i)']

  def set_session_form_values
    FIELDS.each { |field| session[field] = win_params[field] }
  end

  def reset_session_form_values
    FIELDS.each { |field| session[field] = nil } 
  end

  def reset_current_win_id
    session[:current_win_id] = nil
  end

  def win_params
    params.require(:win).permit(:title, :description, :category, :accomplished_date)
  end

  def set_win
    @win = @user.wins.find(params[:id])
  end
end
