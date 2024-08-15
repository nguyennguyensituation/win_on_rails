class WinsController < ApplicationController
  include Pagy::Backend
  include SessionMethods

  before_action :set_user
  before_action :set_win, only: [:show, :edit, :update, :destroy]

  def index  
    session[:current_page] = params[:page] || 1
    @categories = CATEGORIES
    limit = 10
    filtered_wins = apply_filters(@user.wins)      
    session[:total_filtered_wins] = filtered_wins.length;

    @pagy, @wins = pagy(filtered_wins, limit: limit, size: 3)
  end

  def filter
    set_custom_categories
    set_custom_date_range
    redirect_to user_wins_path(@user)
  end

  def reset_filter
    set_default_filter
    redirect_to user_wins_path(@user)
  end

  def new
    @errors = flash[:errors]
  end

  def create
    @win = @user.wins.build(win_params)
    
    if @win.valid?
      @win.save
      reset_win_form_values
      set_earliest_and_latest_win_dates(@user.wins)
      set_default_filter
      redirect_to user_win_path({ user_id: @user.id, id: @win.id }), notice: "#{@win[:title]} added!"
    else
      set_win_form_values
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
      reset_win_form_values
      reset_current_win_id
      set_earliest_and_latest_win_dates(@user.wins)
      redirect_to user_win_path, notice: "#{@win.title} has been updated."
    else
      set_win_form_values
      flash[:errors] = edited_win.errors.full_messages
      redirect_to edit_user_win_path
    end
  end

  def destroy
    @win.destroy
    set_earliest_and_latest_win_dates(@user.wins)
    redirect_to @user, notice: "#{@win.title} has been deleted."
  end

  def cancel
    reset_win_form_values
    @win = @user.wins.find(session[:current_win_id])
    reset_current_win_id
    redirect_to user_win_path({ user_id: @user.id, id: @win.id })
  end

  private

  FIELDS = ['title', 'description', 'category', 'accomplished_date(1i)', 'accomplished_date(2i)', 'accomplished_date(3i)']

  CATEGORIES = ['kudos', 'learning', 'milestone', 'project', 'other']

  def set_win
    @win = @user.wins.find(params[:id])
  end

  def win_params
    params.require(:win).permit(:title, :description, :category, :accomplished_date, :date_start, :date_end)
  end

  def set_win_form_values
    FIELDS.each { |field| session[field] = win_params[field] }
  end

  def reset_win_form_values
    FIELDS.each { |field| session[field] = nil } 
  end

  def reset_current_win_id
    session[:current_win_id] = nil
  end

  def get_date_filter_values(field)
    year, month, day = [1, 2, 3].map { |num| params["[#{field}(#{num}i)]"].to_i }
  end

  def set_custom_date_range
    ['date_start', 'date_end'].each { |field|
      session[field] = Date.new(*get_date_filter_values(field))
    }
  end

  def set_custom_categories
    session[:categories] = ['kudos', 'learning', 'milestone', 'project', 'other'].select{ |category| params[category] }
  end

  def set_default_filter
    session[:date_start] = session[:earliest_win_date]
    session[:date_end] = session[:latest_win_date] 
    session[:categories] = CATEGORIES
  end

  def apply_filters(wins)
    wins.in_range(session[:date_start], session[:date_end])
        .in_category(session[:categories])
        .order(accomplished_date: :asc, title: :asc)
  end
end
