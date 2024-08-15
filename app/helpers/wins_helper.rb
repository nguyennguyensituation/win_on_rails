module WinsHelper
  def populate_date
    year, month, day = [session["accomplished_date(1i)"], session["accomplished_date(2i)"], session["accomplished_date(3i)"]].map(&:to_i)
    isValidDate = [year, month, day].none? { |el| el.zero? }

    return Date.new(year, month, day) if isValidDate
  end

  def populate_sort_by
    session[:sort_by] === 'desc' ? 'newest first' : 'oldest first'
  end
end
