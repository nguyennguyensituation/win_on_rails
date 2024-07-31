module WinsHelper  
  def populate_date
    day = session["accomplished_date(3i)"].to_i
    month = session["accomplished_date(2i)"].to_i
    year = session["accomplished_date(1i)"].to_i
    isValidDate = [day, month, year].none? { |el| el.zero? }

    isValidDate ? Date.new(year, month, day) : Date.today
  end
end
