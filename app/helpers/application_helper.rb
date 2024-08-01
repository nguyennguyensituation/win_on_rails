module ApplicationHelper
  def format_masked_password(length)
    "●" * length
  end

  def format_date(date)
    date.strftime("%d %b %y")
  end
end
