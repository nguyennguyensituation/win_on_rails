# frozen_string_literal: true

# The SessionsMethods module handles session variables
module SessionMethods
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/AbcSize
  def default_session_variables(user)
    earliest_and_latest_win_dates(user.wins)
    session[:user_id] = user.id
    session[:username] = user.username.capitalize
    session[:date_start] = session[:earliest_win_date]
    session[:date_end] = session[:latest_win_date]
    session[:categories] = CATEGORIES
    session[:sort_by] = 'desc'
    session[:query] = ''
  end
  # rubocop:enable Metrics/AbcSize

  def earliest_and_latest_win_dates(wins)
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
