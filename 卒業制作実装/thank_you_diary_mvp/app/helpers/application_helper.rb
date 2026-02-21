module ApplicationHelper
  def time_ago_label(time)
    if Time.current - time < 1.minute
      "たった今"
    else
      "#{time_ago_in_words(time)}前"
    end
  end
end