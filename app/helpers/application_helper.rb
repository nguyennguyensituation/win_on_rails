module ApplicationHelper
  def format_masked_password(length)
    "●" * length
  end

  def format_date(date)
    date.strftime("%B %d, %Y")
  end
end
