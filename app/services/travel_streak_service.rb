class TravelStreakService
  LEVELS = {
    0 => { name: 'Новичок', min_months: 0 },
    1 => { name: 'Исследователь', min_months: 3 },
    2 => { name: 'Путешественник', min_months: 6 },
    3 => { name: 'Легенда путешествий', min_months: 12 }
  }.freeze

  def initialize(user)
    @user = user
  end

  def calculate_streak
    return { current: 0, best: 0, level: level_info(0) } if @user.bookings.confirmed.empty?

    booking_months = @user.bookings.confirmed
                           .order(check_in: :asc)
                           .pluck(:check_in)
                           .map { |date| date.strftime('%Y-%m') }
                           .uniq

    current_streak = calculate_consecutive_months(booking_months)
    best_streak = calculate_best_streak(booking_months)
    current_level = determine_level(current_streak)

    {
      current: current_streak,
      best: best_streak,
      level: current_level,
      next_level: next_level_info(current_streak)
    }
  end

  private

  def calculate_consecutive_months(months)
    return 0 if months.empty?

    sorted_months = months.sort
    current_month = Date.current.strftime('%Y-%m')
    
    # Check if the most recent booking is in the current or previous month
    last_month = sorted_months.last
    return 0 unless consecutive?(last_month, current_month)

    streak = 1
    (sorted_months.length - 2).downto(0) do |i|
      if consecutive?(sorted_months[i], sorted_months[i + 1])
        streak += 1
      else
        break
      end
    end

    streak
  end

  def calculate_best_streak(months)
    return 0 if months.empty?

    sorted_months = months.sort.uniq
    best_streak = 1
    current_streak = 1

    (1...sorted_months.length).each do |i|
      if consecutive?(sorted_months[i - 1], sorted_months[i])
        current_streak += 1
        best_streak = [best_streak, current_streak].max
      else
        current_streak = 1
      end
    end

    best_streak
  end

  def consecutive?(month1, month2)
    date1 = Date.strptime(month1 + '-01', '%Y-%m-%d')
    date2 = Date.strptime(month2 + '-01', '%Y-%m-%d')
    
    (date2 - date1).to_i <= 45 # Allow for some flexibility (up to 1.5 months)
  end

  def determine_level(streak)
    LEVELS.each do |level, info|
      return { level: level, name: info[:name] } if streak >= info[:min_months]
    end
    { level: 0, name: LEVELS[0][:name] }
  end

  def level_info(streak)
    determine_level(streak)
  end

  def next_level_info(current_streak)
    current_level = determine_level(current_streak)[:level]
    return nil if current_level >= LEVELS.length - 1

    next_level_num = current_level + 1
    next_level_data = LEVELS[next_level_num]
    months_needed = next_level_data[:min_months] - current_streak

    {
      level: next_level_num,
      name: next_level_data[:name],
      months_needed: months_needed
    }
  end
end
