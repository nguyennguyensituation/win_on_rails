# frozen_string_literal: true

# ApplicationHelper module includes methods for displaying masked passwords and dates
module ApplicationHelper
  def format_masked_password(length)
    '●' * length
  end

  def format_date(date)
    date.strftime('%d %b %Y')
  end
end
