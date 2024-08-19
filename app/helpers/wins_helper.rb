# frozen_string_literal: true

# WinsHelper module includes logic used for displaying wins and prepopulating values in win forms
module WinsHelper
  def populate_date
    year, month, day = [session['accomplished_date(1i)'],
                        session['accomplished_date(2i)'],
                        session['accomplished_date(3i)']].map(&:to_i)
    is_valid_date = [year, month, day].none?(&:zero?)

    Date.new(year, month, day) if is_valid_date
  end

  def populate_sort_by
    session[:sort_by] == 'desc' ? 'newest first' : 'oldest first'
  end
end
