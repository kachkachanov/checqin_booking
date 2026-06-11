module ApplicationHelper
  def pluralize_hotels(count)
    last_two = count.abs % 100
    last_one = count.abs % 10
    if last_two >= 11 && last_two <= 19
      'отелей'
    elsif last_one == 1
      'отель'
    elsif last_one >= 2 && last_one <= 4
      'отеля'
    else
      'отелей'
    end
  end
end
