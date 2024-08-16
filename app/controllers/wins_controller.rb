class WinsController < ApplicationController
  include Pagy::Backend
  include SessionMethods

  before_action :set_user
  before_action :set_win, only: [:show, :edit, :update, :destroy]
  before_action :set_errors, only: [:new, :edit]

  def index  
    session[:current_page] = params[:page] || 1
    @categories = CATEGORIES
    limit = 8
    filtered_wins = apply_filter(@user.wins)      
    session[:total_filtered_wins] = filtered_wins.length;

    @pagy, @wins = pagy(filtered_wins, limit: limit, size: 3)
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

  def filter
    set_custom_date_range
    set_sort_by
    set_custom_categories
    set_query
    redirect_to user_wins_path(@user)
  end

  def reset_filter
    set_default_filter
    redirect_to user_wins_path(@user)
  end

  private

  FIELDS = ['title', 'description', 'category', 'accomplished_date(1i)', 'accomplished_date(2i)', 'accomplished_date(3i)']

  CATEGORIES = ['kudos', 'learning', 'milestone', 'project', 'other']

  def set_win
    @win = @user.wins.find(params[:id])
  end

  def set_errors
    @errors = flash[:errors]
  end

  def win_params
    params.require(:win).permit(:title, :description, :category, :accomplished_date)
  end

  def filter_params
    params.permit(:sort_by, :kudos, :learning, :milestone, :project, :other, '[date_start(1i)]', '[date_start(2i)]', '[date_start(3i)]', '[date_end(1i)]', '[date_end(2i)]', '[date_end(3i)]', :query)
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
    year, month, day = [1, 2, 3].map { |num| 
    filter_params["[#{field}(#{num}i)]"].to_i 
  }
  end

  def set_custom_date_range
    ['date_start', 'date_end'].each { |field|
      session[field] = Date.new(*get_date_filter_values(field))
    }
  end

  def set_custom_categories
    session[:categories] = CATEGORIES.select{ |category| filter_params[category] }
  end

  def set_sort_by
    session[:sort_by] = filter_params[:sort_by] === 'newest first' ? 'desc' : 'asc' 
  end

  def set_query
    session[:query] = Win.sanitize_sql_like(filter_params[:query])
  end

  def set_default_filter
    session[:date_start] = session[:earliest_win_date]
    session[:date_end] = session[:latest_win_date] 
    session[:categories] = CATEGORIES
    session[:sort_by] = 'desc'
    session[:query] = ''
  end

  def apply_filter(wins)
    wins.in_range(session[:date_start], session[:date_end])
        .in_category(session[:categories])
        .order(accomplished_date: session[:sort_by], title: :asc)
        .contains_string(session[:query])
  end
end
