class WinsController < ApplicationController
  include Pagy::Backend

  before_action :set_user
  before_action :set_win, only: [:show, :edit, :update, :destroy]

  def index    
    session[:current_page] = params[:page] || 1
    

    limit = 8
    @categories = ['any', 'kudos', 'learning', 'milestone', 'project', 'other']
    all_wins = @user.wins
    set_win_date_range(all_wins)
    
    filtered_wins = all_wins.order(accomplished_date: :asc, title: :asc)
    session[:total_filtered_wins] = filtered_wins.length;

    @pagy, @wins = pagy(filtered_wins, limit: limit, size: 3)
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

  def set_win
    @win = @user.wins.find(params[:id])
  end

  def win_params
    params.require(:win).permit(:title, :description, :category, :accomplished_date)
  end

  def set_session_form_values
    FIELDS.each { |field| session[field] = win_params[field] }
  end

  def reset_session_form_values
    FIELDS.each { |field| session[field] = nil } 
  end

  def reset_current_win_id
    session[:current_win_id] = nil
  end

  def set_win_date_range(wins)
    if wins.empty?
      session[:earliest_win_date] = Date.today
      session[:latest_win_date] = Date.today
    else
      sorted_wins = wins.order(accomplished_date: :asc)
      session[:earliest_win_date] = sorted_wins.first.accomplished_date
      session[:latest_win_date] = sorted_wins.last.accomplished_date
    end
  end
end
